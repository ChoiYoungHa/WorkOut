package poly.service;

import poly.dto.MemberDTO;

public interface ICoreService {
    // 맴버의 목표칼로리 산정여부 체크
    public MemberDTO checkMemberGK(MemberDTO pDTO) throws Exception;

    // 맴버의 목표칼로리 저장
    public void insertGk(MemberDTO pDTO) throws Exception;

}
