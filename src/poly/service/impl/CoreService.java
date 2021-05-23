package poly.service.impl;
import org.apache.log4j.Logger;

import org.springframework.stereotype.Service;
import poly.dto.MemberDTO;
import poly.persistance.mapper.ICoreMapper;
import poly.service.ICoreService;

import javax.annotation.Resource;

@Service("CoreService")
public class CoreService implements ICoreService {

    @Resource(name = "CoreMapper")
    private ICoreMapper coreMapper;

    private Logger log = Logger.getLogger(this.getClass());

    // 맴버의 목표칼로리 산정여부 체크
    @Override
    public MemberDTO checkMemberGK(MemberDTO pDTO) throws Exception {
        return coreMapper.checkMemberGK(pDTO);
    }

    // 맴버의 목표칼로리 저장
    @Override
    public void insertGk(MemberDTO pDTO) throws Exception {
        coreMapper.insertGk(pDTO);
    }


}
