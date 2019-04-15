package com.kafei.module.opInfo.service;

import com.kafei.mapper.OpInfoMapper;
import com.kafei.util.PropsConfig;
import com.kafei.util.QRCodeUtil;
import com.kafei.vo.OpInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Service
public class OpInfoServiceImpl implements OpInfoService{
    @Autowired
    private OpInfoMapper mapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return mapper.deleteByPrimaryKey(id);
    }

    @Override
    @Transactional
    public int insertSelective(OpInfo record,Integer orgId, HttpServletRequest request) throws Exception {
        mapper.insertSelective(record);
        if(record.getType().equals("表决"))
            record.setQrCode(createQrCodeBiaoJue(record.getId(), orgId, request));
        if(record.getType().equals("意见"))
            record.setQrCode(createQrCodeYijian(record.getId(), orgId, request));
        if(record.getType().equals("报名"))
            record.setQrCode(createQrCodeBaoming(record.getId(), orgId, request));
        return mapper.updateByPrimaryKeySelective(record);
    }

    public String createQrCodeBiaoJue(Integer id,Integer orgId, HttpServletRequest request) throws Exception {
        String uploadPath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort();
        String rootPath = PropsConfig.getPropValue("pic_real_path");
        rootPath = rootPath+"/biaojue";
        QRCodeUtil.encode(uploadPath+request.getContextPath() + "/menu/decide.html?id="+id+"&orgId="+orgId, "", rootPath, true, String.valueOf(id));
        return uploadPath + "/upload/biaojue/" + String.valueOf(id) + ".jpg";
    }
    public String createQrCodeBaoming(Integer id,Integer orgId, HttpServletRequest request) throws Exception {
        String uploadPath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort();
        String rootPath = PropsConfig.getPropValue("pic_real_path");
        rootPath = rootPath+"/baoming";
        QRCodeUtil.encode(uploadPath+request.getContextPath() + "/menu/apply.html?id="+id+"&orgId="+orgId, "", rootPath, true, String.valueOf(id));
        return uploadPath + "/upload/baoming/" + String.valueOf(id) + ".jpg";
    }
    public String createQrCodeYijian(Integer id,Integer orgId, HttpServletRequest request) throws Exception {
        String uploadPath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort();
        String rootPath = PropsConfig.getPropValue("pic_real_path");
        rootPath = rootPath+"/yijian";
        QRCodeUtil.encode(uploadPath+request.getContextPath() + "/menu/opinion.html?id="+id+"&orgId="+orgId, "", rootPath, true, String.valueOf(id));
        return uploadPath + "/upload/yijian/" + String.valueOf(id) + ".jpg";
    }


    @Override
    public OpInfo selectByPrimaryKey(Integer id) {
        mapper.updateViewNum(id);
        return mapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(OpInfo record) {
        return mapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<OpInfo> selectList(OpInfo opInfo) {
        return mapper.selectList(opInfo);
    }

    @Override
    public List<OpInfo> selectByIds(String ids) {
        String[] arr = ids.split(",");
        List<Integer> list = new ArrayList<>();
        for(String id:arr){
            list.add(Integer.parseInt(id));
        }
        return mapper.selectByIds(list);
    }
}
