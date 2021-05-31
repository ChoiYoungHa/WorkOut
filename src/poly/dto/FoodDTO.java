package poly.dto;

public class FoodDTO {
    private String food_id; // 식단번호
    private String member_id; // 회원번호
    private String food_time; // 섭취 시간 (아침,점심,저녁)
    private String food_name; // 음식이름
    private String food_brand; // 음식 제조사
    private String food_gram; // 음식 량
    private String food_kcal; // 음식 칼로리
    private String tan; // 탄수화물
    private String dan; // 단백질
    private String fat; // 지방
    private String amount; // 음식개수

    public String getFood_brand() {
        return food_brand;
    }

    public void setFood_brand(String food_brand) {
        this.food_brand = food_brand;
    }

    public String getFood_id() {
        return food_id;
    }

    public void setFood_id(String food_id) {
        this.food_id = food_id;
    }

    public String getMember_id() {
        return member_id;
    }

    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }

    public String getFood_time() {
        return food_time;
    }

    public void setFood_time(String food_time) {
        this.food_time = food_time;
    }

    public String getFood_name() {
        return food_name;
    }

    public void setFood_name(String food_name) {
        this.food_name = food_name;
    }

    public String getFood_gram() {
        return food_gram;
    }

    public void setFood_gram(String food_gram) {
        this.food_gram = food_gram;
    }

    public String getFood_kcal() {
        return food_kcal;
    }

    public void setFood_kcal(String food_kcal) {
        this.food_kcal = food_kcal;
    }

    public String getTan() {
        return tan;
    }

    public void setTan(String tan) {
        this.tan = tan;
    }

    public String getDan() {
        return dan;
    }

    public void setDan(String dan) {
        this.dan = dan;
    }

    public String getFat() {
        return fat;
    }

    public void setFat(String fat) {
        this.fat = fat;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }
}
