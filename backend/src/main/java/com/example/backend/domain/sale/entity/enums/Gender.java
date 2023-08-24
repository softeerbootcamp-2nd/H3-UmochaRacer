package com.example.backend.domain.sale.entity.enums;

public enum Gender {
    MALE("남성"),
    FEMALE("여성"),
    NONE("무관")
    ;
    private String korean;

    Gender(String korean) {
        this.korean = korean;
    }

    public String getQueryString() {
        if(this == NONE)
            return " ";
        return "gender = \'" + this.name() + "\' AND ";
    }
}
