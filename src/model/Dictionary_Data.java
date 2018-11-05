package model;

public class Dictionary_Data {

    private Integer Id;
    private String dict_Id;
    private String dict_data_name;
    private String dict_data_value;
    private Integer is_fixed;
    private String memo;

    public Integer getId() {
        return Id;
    }

    public void setId(Integer id) {
        Id = id;
    }

    public String getDict_Id() {
        return dict_Id;
    }

    public void setDict_Id(String dict_Id) {
        this.dict_Id = dict_Id;
    }

    public String getDict_data_name() {
        return dict_data_name;
    }

    public void setDict_data_name(String dict_data_name) {
        this.dict_data_name = dict_data_name;
    }

    public String getDict_data_value() {
        return dict_data_value;
    }

    public void setDict_data_value(String dict_data_value) {
        this.dict_data_value = dict_data_value;
    }

    public Integer getIs_fixed() {
        return is_fixed;
    }

    public void setIs_fixed(Integer is_fixed) {
        this.is_fixed = is_fixed;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }
}
