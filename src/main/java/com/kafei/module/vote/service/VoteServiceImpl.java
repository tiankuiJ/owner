package com.kafei.module.vote.service;

import com.kafei.mapper.CandidateMapper;
import com.kafei.mapper.VoteMapper;
import com.kafei.util.PropsConfig;
import com.kafei.util.QRCodeUtil;
import com.kafei.vo.Candidate;
import com.kafei.vo.Vote;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class VoteServiceImpl implements VoteService{

    @Autowired
    private VoteMapper mapper;
    @Autowired
    private CandidateMapper candidateMapper;
    @Override
    public int deleteByPrimaryKey(Integer id) {
        return mapper.deleteByPrimaryKey(id);
    }


    public String createQrCode(Integer id,Integer orgId, HttpServletRequest request) throws Exception {
        String uploadPath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort();
        String rootPath = PropsConfig.getPropValue("pic_real_path");
        rootPath = rootPath+"/vote";
        QRCodeUtil.encode(uploadPath+request.getContextPath() + "/menu/vote.html?id="+id+"&orgId="+orgId, "", rootPath, true, String.valueOf(id));
        return uploadPath + "/upload/vote/" + String.valueOf(id) + ".jpg";
    }

    @Override
    @Transactional
    public int insertSelective(Vote record, List<Candidate> candidates,Integer orgId, HttpServletRequest request) throws Exception {
        mapper.insertSelective(record);
        for(Candidate candidate:candidates){
            candidate.setVoteId(record.getId());
            candidateMapper.insertSelective(candidate);
        }
        String qrCode = createQrCode(record.getId(), orgId, request);
        record.setQrCode(qrCode);
        return mapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public Vote selectByPrimaryKey(Integer id) {
        return mapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Vote record, List<Candidate> candidates) {
        mapper.updateByPrimaryKeySelective(record);
        for(Candidate candidate:candidates){
            if(candidate.getId()!=null){
                candidateMapper.updateByPrimaryKeySelective(candidate);
            }else{
                candidate.setVoteId(record.getId());
                candidateMapper.insertSelective(candidate);
            }
        }
        return 1;
    }

    @Override
    public List<Vote> selectList(Vote vote) {
        return mapper.selectList(vote);
    }

    @Override
    public List<Candidate> selectOptions(Candidate candidate) {
        return candidateMapper.selectList(candidate);
    }
}
