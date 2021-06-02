package poly.service;

import poly.dto.FoodDTO;
import poly.dto.MemberDTO;

import java.util.List;

public interface ICoreService {
    // 맴버의 목표칼로리 산정여부 체크
    public MemberDTO checkMemberGK(MemberDTO pDTO) throws Exception;

    // 맴버의 목표칼로리 저장
    public void insertGk(MemberDTO pDTO) throws Exception;

    // 회원 별 섭취한 음식 저장
    public void insertFood(FoodDTO pDTO) throws Exception;

    // 회원 별 섭취한 음식 리스트 가져오기
    public List<FoodDTO> find_FoodData(FoodDTO pDTO) throws Exception;

    // 회원 별 섭취한 음식 삭제
    public void deleteFood(FoodDTO pDTO) throws Exception;


}
