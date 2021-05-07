package poly.dto;

public class NoticeDTO {

    // 게시판
    private String post_id; // 게시글 번호
    private String post_category; // 게시글분류
    private String bookmark; // 북마크 여부
    private String post_title; // 글 제목
    private int post_view; // 조회수
    private int post_recom; // 추천수
    private String content; // 글 내용

    //회원
    private String member_id; // 회원번호
    private String member_nic; // 회원 닉네임

    public String getPost_category() {
        return post_category;
    }

    public void setPost_category(String post_category) {
        this.post_category = post_category;
    }

    public String getBookmark() {
        return bookmark;
    }

    public void setBookmark(String bookmark) {
        this.bookmark = bookmark;
    }

    public String getPost_title() {
        return post_title;
    }

    public void setPost_title(String post_title) {
        this.post_title = post_title;
    }

    public int getPost_view() {
        return post_view;
    }

    public void setPost_view(int post_view) {
        this.post_view = post_view;
    }

    public int getPost_recom() {
        return post_recom;
    }

    public void setPost_recom(int post_recom) {
        this.post_recom = post_recom;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getMember_id() {
        return member_id;
    }

    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }

    public String getPost_id() {
        return post_id;
    }

    public void setPost_id(String post_id) {
        this.post_id = post_id;
    }

    public String getMember_nic() {
        return member_nic;
    }

    public void setMember_nic(String member_nic) {
        this.member_nic = member_nic;
    }
}
