package poly.persistance.mapper;

import config.Mapper;
import poly.dto.MemberDTO;

@Mapper("CoreMapper")
public interface ICoreMapper {
    // 맴버의 목표칼로리 산정여부 체크
    public MemberDTO checkMemberGK(MemberDTO pDTO) throws Exception;

    // 맴버의 목표칼로리 저장
    public void insertGk(MemberDTO pDTO) throws Exception;

}
