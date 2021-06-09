package poly.persistance.mapper;

import config.Mapper;
import poly.dto.MemberDTO;
import poly.dto.NoticeDTO;

import java.util.List;

@Mapper("MemberMapper")
public interface IMemberMapper {

    // 회원 가입하기(회원정보 등록)
    int insertMember(MemberDTO pDTO) throws Exception;

    // 회원 가입 전, 중복 회원가입 방지
    MemberDTO emailCheck(String email) throws Exception;

    // 로그인하기
    MemberDTO getLogin(MemberDTO pDTO) throws Exception;

    // 비밀번호 변경
    int update_pw(MemberDTO pDTO) throws Exception;

    // 회원정보 조회
    MemberDTO member_find(MemberDTO pDTO) throws Exception;

    // 마이페이지에서 비밀번호 변경
    int myPage_update_pw(MemberDTO pDTO) throws Exception;

    // 북마크 게시물리스트 가져오기
    List<NoticeDTO> bookMarkGetList(NoticeDTO pDTO) throws Exception;

}