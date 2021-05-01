package poly.dto;

public class MemberDTO {

    //회원가입 시 입력 정보
    private String email; //이메일
    private String member_pw; //비밀번호
    private String member_name; //회원이름
    private String member_nic; // 닉네임
    private int member_gk; // 목표칼로리

    //회원번호 생성
    private String member_id; //회원번호

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMember_pw() {
        return member_pw;
    }

    public void setMember_pw(String member_pw) {
        this.member_pw = member_pw;
    }

    public String getMember_name() {
        return member_name;
    }

    public void setMember_name(String member_name) {
        this.member_name = member_name;
    }

    public String getMember_nic() {
        return member_nic;
    }

    public void setMember_nic(String member_nic) {
        this.member_nic = member_nic;
    }

    public int getMember_gk() {
        return member_gk;
    }

    public void setMember_gk(int member_gk) {
        this.member_gk = member_gk;
    }

    public String getMember_id() {
        return member_id;
    }

    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }
}
