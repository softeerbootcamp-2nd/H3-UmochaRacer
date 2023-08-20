package com.example.backend.domain.information.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
public class CommentResponse {
    private String comment;

    public CommentResponse(String comment){
        this.comment = comment;
    }
}
