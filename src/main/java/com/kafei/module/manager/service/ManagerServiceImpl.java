package com.kafei.module.manager.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.kafei.mapper.ManagerMapper;
import com.kafei.mapper.OwnerMapper;
import com.kafei.util.AESUtil;
import com.kafei.vo.Manager;
import com.kafei.vo.Owner;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class ManagerServiceImpl implements ManagerService {
    @Autowired
    private ManagerMapper managerMapper;

    @Autowired
    private OwnerMapper ownerMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return managerMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int updateOwnerOrg(Owner owner) {
        return ownerMapper.updateOwnerOrg(owner);
    }

    @Override
    public int insertOwnerOrg(Owner owner) {
        return ownerMapper.insertOwnerOrg(owner);
    }

    @Override
    public int deleteOwnerOrg(Integer id) {
        return ownerMapper.deleteOwnerOrg(id);
    }

    @Override
    @Transactional(isolation = Isolation.SERIALIZABLE)
    public int insertSelective(Manager record) {
        record.setPsd("123456");
        Manager temp = new Manager();
        temp.setAccount(record.getAccount());
        if (selectList(temp).size() != 0) {//已经存在该账户
            return -1;
        }
        try {
            record.setPsd(AESUtil.getInstance().encrypt(record.getPsd()));
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
        return managerMapper.insertSelective(record);
    }

    @Override
    public Manager selectByPrimaryKey(Integer id) {
        return managerMapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Manager record) {
        return managerMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public Manager login(Manager manager) {
        try {
            manager.setPsd(AESUtil.getInstance().encrypt(manager.getPsd()));
            manager = managerMapper.login(manager);
            return manager;
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Manager> selectList(Manager manager) {
        return managerMapper.selectList(manager);
    }

    @Override
    public List<Owner> selectOwnerList(Owner owner) {
        return ownerMapper.selectList(owner);
    }

    @Override
    public int insertOwner(Owner owner) {
        List<Owner> list = ownerMapper.selectList(new Owner(owner.getPhone()));
        if (list.size() > 0)
            return -1;
//        try {
//            owner.setPsd(AESUtil.getInstance().encrypt("123456"));
//        } catch (Exception e) {
//            e.printStackTrace();
//            return 0;
//        }
        return ownerMapper.insertSelective(owner);
    }

    @Override
    public int updateOwner(Owner owner) {
        if (owner.getOldPhone().equals(owner.getPhone())) {
            owner.setOldPhone(null);
            return ownerMapper.updateByPrimaryKeySelective(owner);
        }
        List<Owner> list = ownerMapper.selectList(new Owner(owner.getPhone()));
        if (list.size() > 0)
            return -1;
        return ownerMapper.updateByPrimaryKeySelective(owner);
    }


    private final static String excel2003L = ".xls";    //2003- 版本的excel
    private final static String excel2007U = ".xlsx";   //2007+ 版本的excel

    public Workbook getWorkbook(InputStream inStr, String fileName) throws Exception {
        Workbook wb = null;
        String fileType = fileName.substring(fileName.lastIndexOf("."));
        if (excel2003L.equals(fileType)) {
            wb = new HSSFWorkbook(inStr);  //2003-
        } else if (excel2007U.equals(fileType)) {
            wb = new XSSFWorkbook(inStr);  //2007+
        } else {
            throw new Exception("解析的文件格式有误！");
        }
        return wb;
    }
    @Autowired
    private DataSourceTransactionManager transactionManager;
    @Override
//    @Transactional
    public JSONObject importOwner(InputStream in, String fileName, Integer orgId) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
        TransactionStatus status = transactionManager.getTransaction(def); // 获得事务状态
        JSONObject result = new JSONObject();
        List<Object> list = null;
        List<ErrorObj> errors = new ArrayList<>();
        String[] attrs = new String[]{"position", "name", "phone", "phonet", "acreage","psd", "remark"};

        //创建Excel工作薄
        try {
            Workbook work = this.getWorkbook(in, fileName);
            if (null == work) {
                throw new Exception("创建Excel工作薄为空！");
            }
            Sheet sheet = null;
            Row row = null;
            Cell cell = null;
            list = new ArrayList<>();
            for (int i = 0; i < work.getNumberOfSheets(); i++) {
                sheet = work.getSheetAt(i);
                if (sheet == null) {
                    continue;
                }

                //遍历当前sheet中的所有行
                System.out.println(sheet.getLastRowNum()+"!!");
                for (int j = sheet.getFirstRowNum() + 1; j < sheet.getLastRowNum() + 1; j++) {
                    row = sheet.getRow(j);
                    if (row == null || row.getFirstCellNum() == j) {
                        System.out.println(j+"???");
                        continue;
                    }

                    JSONObject ownerObj = new JSONObject();
                    ownerObj.put("orgId", orgId);
                    //遍历所有的列
                    for (int y = row.getFirstCellNum(); y < row.getLastCellNum(); y++) {
                        cell = row.getCell(y);
//                        if(cell==null){
//                            System.out.println(sheet.getSheetName()+j+"|"+y);
//                            break;
//                        }
                        Owner owner;
                        if (StringUtils.isBlank(getCellValueToString(cell)) && y!=3 && y!=6 ) {
                            ErrorObj errorObj = new ErrorObj();
                            errorObj.setErrorRowIndex((sheet.getSheetName()+"|"+(j+1) + ""));
                            errorObj.setErrorContent("请填入完整的信息");
                            errors.add(errorObj);
                            break;
                        }
                        if (cell.getColumnIndex() == 2) {
                            try {
                                owner = new Owner(Long.parseLong(getCellValueToString(row.getCell(y))));
                                if (ownerMapper.selectList(owner).size() > 0) {
                                    ErrorObj errorObj = new ErrorObj();
                                    errorObj.setErrorRowIndex((sheet.getSheetName()+"|"+(j+1) + ""));
                                    errorObj.setErrorContent("手机号重复");
                                    errors.add(errorObj);
                                    break;
                                }
                                owner.setPhone(null);
                                owner.setPsd(getCellValueToString(row.getCell(5)));
                                if (StringUtils.isBlank(owner.getPsd())) {
                                    ErrorObj errorObj = new ErrorObj();
                                    errorObj.setErrorRowIndex((sheet.getSheetName()+"|"+(j+1) + ""));
                                    errorObj.setErrorContent("身份证号码不能为空");
                                    errors.add(errorObj);
                                    break;
                                }
                                if (ownerMapper.selectList(owner).size() > 0) {
                                    ErrorObj errorObj = new ErrorObj();
                                    errorObj.setErrorRowIndex((sheet.getSheetName()+"|"+(j+1) + ""));
                                    errorObj.setErrorContent("身份证号码重复");
                                    errors.add(errorObj);
                                    break;
                                }
                            } catch (Exception e) {
                                ErrorObj errorObj = new ErrorObj();
                                errorObj.setErrorRowIndex((sheet.getSheetName()+"|"+(j+1) + ""));
                                errorObj.setErrorContent("手机号格式错误");
                                errors.add(errorObj);
                                break;
                            }
                            try {
                                Double.parseDouble(getCellValueToString(row.getCell(4)));
                            } catch (Exception e) {
                                ErrorObj errorObj = new ErrorObj();
                                errorObj.setErrorRowIndex((sheet.getSheetName()+"|"+(j+1) + ""));
                                errorObj.setErrorContent("面积格式错误");
                                errors.add(errorObj);
                                break;
                            }
                        }
                        ownerObj.put(attrs[y], getCellValueToString(cell));
                        if (cell.getColumnIndex() == 6) {
                            list.add(ownerObj);
                        }
                    }

                }
            }
            result.put("owners", list);
            System.out.println(JSON.toJSONString(list));
            result.put("errors", errors);
            if (result.get("errors").toString().length() < 3) {
                ArrayList<Owner> records = JSON.parseObject(result.get("owners").toString(), new TypeReference<ArrayList<Owner>>() {
                });
                ownerMapper.insertBatch(records);
                transactionManager.commit(status);
            } else {
                transactionManager.rollback(status);
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            transactionManager.rollback(status);
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> selectOwnerOrgList(Owner owner) {
        return ownerMapper.selectOwnerOrgList(owner);
    }

    private static String getCellValueToString(Cell cell) {
        String strCell = "";
        String pattern = "yyyy-MM-dd";
        if (cell == null) {
            return null;
        }
        switch (cell.getCellType()) {
            case Cell.CELL_TYPE_BOOLEAN:
                strCell = String.valueOf(cell.getBooleanCellValue());
                break;
            case Cell.CELL_TYPE_NUMERIC:
                if (HSSFDateUtil.isCellDateFormatted(cell)) {
                    Date date = cell.getDateCellValue();
                    if (pattern != null) {
                        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
                        strCell = sdf.format(date);
                    } else {
                        strCell = date.toString();
                    }
                    break;
                }
                // 不是日期格式，则防止当数字过长时以科学计数法显示
                cell.setCellType(HSSFCell.CELL_TYPE_STRING);
                strCell = cell.toString();
                break;
            case Cell.CELL_TYPE_STRING:
                strCell = cell.getStringCellValue();
                break;
            default:
                break;
        }
        return strCell;
    }


    class ErrorObj {
        private String errorRowIndex;

        private String errorContent;

        public String getErrorRowIndex() {
            return errorRowIndex;
        }

        public void setErrorRowIndex(String errorRowIndex) {
            this.errorRowIndex = errorRowIndex;
        }

        public String getErrorContent() {
            return errorContent;
        }

        public void setErrorContent(String errorContent) {
            this.errorContent = errorContent;
        }
    }

}
