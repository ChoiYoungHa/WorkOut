package poly.service.impl;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import poly.dto.MemberDTO;
import poly.dto.NoticeDTO;
import poly.persistance.mapper.IMemberMapper;
import poly.service.IMemberService;

import javax.annotation.Resource;
import java.util.List;

@Service("MemberService")
public class MemberService implements IMemberService {

    private Logger log = Logger.getLogger(this.getClass());

    @Resource(name="MemberMapper")
    private IMemberMapper memberMapper;

    // 회원가입
    @Override
    public int insertMember(MemberDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".insertMember Start!");
        return memberMapper.insertMember(pDTO);
    }

    // 이메일 중복 확인
    @Override
    public MemberDTO emailCheck(String email) throws Exception {
        return memberMapper.emailCheck(email);
    }

    // 로그인하기
    @Override
    public MemberDTO getLogin(MemberDTO pDTO) throws Exception {
        return memberMapper.getLogin(pDTO);
    }

    // 비밀번호 변경
    @Override
    public int update_pw(MemberDTO pDTO) throws Exception {
        return memberMapper.update_pw(pDTO);
    }

    // 회원정보 조회
    @Override
    public MemberDTO member_find(MemberDTO pDTO) throws Exception {
        return memberMapper.member_find(pDTO);
    }

    // 마이페이지에서 비밀번호 변경
    @Override
    public int myPage_update_pw(MemberDTO pDTO) throws Exception {
        return memberMapper.myPage_update_pw(pDTO);
    }

    @Override
    public List<NoticeDTO> bookMarkGetList(NoticeDTO pDTO) throws Exception {
        return memberMapper.bookMarkGetList(pDTO);
    }


}
