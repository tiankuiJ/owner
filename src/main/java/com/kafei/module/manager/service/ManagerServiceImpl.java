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
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Service
public class ManagerServiceImpl implements ManagerService{
    @Autowired
    private ManagerMapper managerMapper;

    @Autowired
    private OwnerMapper ownerMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return managerMapper.deleteByPrimaryKey(id);
    }

    @Override
    @Transactional(isolation = Isolation.SERIALIZABLE)
    public int insertSelective(Manager record) {
        record.setPsd("123456");
        Manager temp = new Manager();
        temp.setAccount(record.getAccount());
        if(selectList(temp).size()!=0){//已经存在该账户
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
        }catch (Exception e){
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
        if(list.size()>0)
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
        if(owner.getOldPhone().equals(owner.getPhone())){
            owner.setOldPhone(null);
            return ownerMapper.updateByPrimaryKeySelective(owner);
        }
        List<Owner> list = ownerMapper.selectList(new Owner(owner.getPhone()));
        if(list.size()>0)
            return -1;
        return ownerMapper.updateByPrimaryKeySelective(owner);
    }


    private final static String excel2003L =".xls";    //2003- 版本的excel
    private final static String excel2007U =".xlsx";   //2007+ 版本的excel
    public Workbook getWorkbook(InputStream inStr, String fileName) throws Exception{
        Workbook wb = null;
        String fileType = fileName.substring(fileName.lastIndexOf("."));
        if(excel2003L.equals(fileType)){
            wb = new HSSFWorkbook(inStr);  //2003-
        }else if(excel2007U.equals(fileType)){
            wb = new XSSFWorkbook(inStr);  //2007+
        }else{
            throw new Exception("解析的文件格式有误！");
        }
        return wb;
    }

    @Override
    @Transactional
    public JSONObject importOwner(InputStream in, String fileName,Integer orgId){
        JSONObject result = new JSONObject();
        List<Object> list = null;
        JSONObject robj = new JSONObject();
        List<ErrorObj> errors = new ArrayList<>();
//        String[] attrs = new String[]{"name","sex","psd","phone","job","birth","whcd","zzmm","position","remark"};
        String[] attrs = new String[]{"position","name","acreage","phone","phonet","psd","remark"};

        //创建Excel工作薄
        try {
            Workbook work = this.getWorkbook(in,fileName);
            if(null == work){
                throw new Exception("创建Excel工作薄为空！");
            }
            Sheet sheet = null;
            Row row = null;
            Cell cell = null;
            list = new ArrayList<>();
            //遍历Excel中所有的sheet
            DecimalFormat df = new DecimalFormat("0");  //格式化number String字符
            SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");  //日期格式化
            DecimalFormat df2 = new DecimalFormat("0.00");  //格式化数字
            for (int i = 0; i < work.getNumberOfSheets(); i++) {
                sheet = work.getSheetAt(i);
                if(sheet==null){continue;}

                //遍历当前sheet中的所有行
                for (int j = sheet.getFirstRowNum()+1; j < sheet.getLastRowNum()+1; j++) {
                    row = sheet.getRow(j);
                    if(row==null||row.getFirstCellNum()==j){
                        continue;
                    }

                    //遍历所有的列
                    JSONObject ownerObj = new JSONObject();
                    ownerObj.put("orgId",orgId);
//                    if(row.getLastCellNum()<7){
//                        ErrorObj errorObj = new ErrorObj();
//                        errorObj.setErrorRowIndex((j+""));
//                        errorObj.setErrorContent("请把信息输入完整");
//                        errors.add(errorObj);
//                    }
                    for (int y = row.getFirstCellNum(); y < row.getLastCellNum(); y++) {
                        cell = row.getCell(y);
                        Object value = null;
                        Owner owner;
                        if(cell==null){
                            ownerObj.put(attrs[y],null);
                            if(y==5){
                                ErrorObj errorObj = new ErrorObj();
                                errorObj.setErrorRowIndex((j+""));
                                errorObj.setErrorContent("身份证号码不能为空");
                                errors.add(errorObj);
                            }
                            if(y==3){
                                ErrorObj errorObj = new ErrorObj();
                                errorObj.setErrorRowIndex((j+""));
                                errorObj.setErrorContent("电话号码不能为空");
                                errors.add(errorObj);
                            }
                            if(y==2){
                                ErrorObj errorObj = new ErrorObj();
                                errorObj.setErrorRowIndex((j+""));
                                errorObj.setErrorContent("面积不能为空");
                                errors.add(errorObj);
                            }
                            continue;
                        }
                        if(cell.getColumnIndex()==2){
                            try {
                                if(Long.parseLong(df.format(row.getCell(y+1).getNumericCellValue()))==0L){
                                    ErrorObj errorObj = new ErrorObj();
                                    errorObj.setErrorRowIndex((j+""));
                                    errorObj.setErrorContent("电话号码不能为空");
                                    errors.add(errorObj);
                                    continue;
                                }
                                owner = new Owner(Long.parseLong(df.format(row.getCell(y+1).getNumericCellValue())));
                                if(ownerMapper.selectList(owner).size()>0){
                                    ErrorObj errorObj = new ErrorObj();
                                    errorObj.setErrorRowIndex((j+""));
                                    errorObj.setErrorContent("手机号重复");
                                    errors.add(errorObj);
                                    continue;
                                }
                                owner.setPhone(null);
                                owner.setPsd(row.getCell(5).getRichStringCellValue().getString());
                                if(StringUtils.isBlank(owner.getPsd())){
                                    ErrorObj errorObj = new ErrorObj();
                                    errorObj.setErrorRowIndex((j+""));
                                    errorObj.setErrorContent("身份证号码不能为空");
                                    errors.add(errorObj);
                                    continue;
                                }
                                if(ownerMapper.selectList(owner).size()>0){
                                    ErrorObj errorObj = new ErrorObj();
                                    errorObj.setErrorRowIndex((j+""));
                                    errorObj.setErrorContent("身份证号码重复");
                                    errors.add(errorObj);
                                    continue;
                                }
                            }catch (Exception e){
                                ErrorObj errorObj = new ErrorObj();
                                errorObj.setErrorRowIndex((j+""));
                                errorObj.setErrorContent("手机号格式错误");
                                errors.add(errorObj);
                                continue;
                            }

                        }
                        switch (cell.getCellType()) {
                            case Cell.CELL_TYPE_STRING:
                                value = cell.getRichStringCellValue().getString();
                                break;
                            case Cell.CELL_TYPE_NUMERIC:
                                if("General".equals(cell.getCellStyle().getDataFormatString())){
                                    value = df.format(cell.getNumericCellValue());
                                }else if("m/d/yy".equals(cell.getCellStyle().getDataFormatString())){
                                    value = sdf.format(cell.getDateCellValue());
                                }else{
                                    value = df2.format(cell.getNumericCellValue());
                                }
                                break;
                            case Cell.CELL_TYPE_BOOLEAN:
                                value = cell.getBooleanCellValue();
                                break;
                            case Cell.CELL_TYPE_BLANK:
                                value = "";
                                break;
                            default:
                                break;
                        }
                        try {
                            if(cell.getColumnIndex()==2){
                                Double.parseDouble(df2.format(cell.getNumericCellValue()));
                            }
                        }catch (Exception e){
                            ErrorObj errorObj = new ErrorObj();
                            errorObj.setErrorRowIndex((j+""));
                            errorObj.setErrorContent("面积不能为空或格式错误");
                            errors.add(errorObj);
                            continue;
                        }

                        ownerObj.put(attrs[y],value);
                    }
                    list.add(ownerObj);
                }
            }
            System.out.println(JSON.toJSONString(errors));
            System.out.println(JSON.toJSONString(list));
            result.put("owners",list);
            result.put("errors",errors);
            if(result.get("errors").toString().length()<3){
                ArrayList<Owner> records = JSON.parseObject(result.get("owners").toString(), new TypeReference<ArrayList<Owner>>() {});
                ownerMapper.insertBatch(records);
            }
            return result;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }


    class ErrorObj{
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
