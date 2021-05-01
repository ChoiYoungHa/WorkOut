package poly.persistance.mapper;

import config.Mapper;
import poly.dto.MemberDTO;

@Mapper("MemberMapper")
public interface IMemberMapper {

    // 회원 가입하기(회원정보 등록)
    int insertMember(MemberDTO pDTO) throws Exception;

    // 회원 가입 전, 중복 회원가입 방지
    MemberDTO emailCheck(String email) throws Exception;

    //  로그인하기
    MemberDTO getLogin(MemberDTO pDTO) throws Exception;

}