package com.kafei.module.activity.service;

import com.kafei.mapper.ActivityMapper;
import com.kafei.util.PropsConfig;
import com.kafei.util.QRCodeUtil;
import com.kafei.vo.Activity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class ActivityServiceImpl implements ActivityService{
    @Autowired
    private ActivityMapper mapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return mapper.deleteByPrimaryKey(id);
    }

    @Override
    @Transactional
    public int insertSelective(Activity record,Integer orgId, HttpServletRequest request) throws Exception {
        mapper.insertSelective(record);
            String qrCode = createQrCode(record.getId(), orgId, request);
            record.setQrCode(qrCode);
        return mapper.updateByPrimaryKeySelective(record);
    }

    public String createQrCode(Integer id,Integer orgId, HttpServletRequest request) throws Exception {
        String uploadPath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort();
        String rootPath = PropsConfig.getPropValue("pic_real_path");
        rootPath = rootPath+"/activity";
        QRCodeUtil.encode(uploadPath+request.getContextPath() + "/index.html?id="+id+"&orgId="+orgId, "", rootPath, true, String.valueOf(id));
        return uploadPath + "/upload/activity/" + String.valueOf(id) + ".jpg";
    }

    @Override
    public Activity selectByPrimaryKey(Integer id) {
        return mapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Activity record) {
        return mapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<Activity> selectList(Activity activity) {
        return mapper.selectList(activity);
    }

    @Override
    public int delete(Integer id) {
        return mapper.delete(id);
    }
}
