package poly.service.impl;
import org.apache.log4j.Logger;

import org.springframework.stereotype.Service;
import poly.dto.FoodDTO;
import poly.dto.MemberDTO;
import poly.persistance.mapper.ICoreMapper;
import poly.service.ICoreService;

import javax.annotation.Resource;
import java.util.List;

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

    // 회원 별 섭취한 음식 저장
    @Override
    public void insertFood(FoodDTO pDTO) throws Exception {
        coreMapper.insertFood(pDTO);
    }

    // 회원 별 섭취한 음식 리스트 가져오기
    @Override
    public List<FoodDTO> find_FoodData(FoodDTO pDTO) throws Exception {
        return coreMapper.find_FoodData(pDTO);
    }

    @Override
    public void deleteFood(FoodDTO pDTO) throws Exception {
        coreMapper.deleteFood(pDTO);
    }


}
