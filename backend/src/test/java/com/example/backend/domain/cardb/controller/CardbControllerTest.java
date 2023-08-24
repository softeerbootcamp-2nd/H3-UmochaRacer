package com.example.backend.domain.cardb.controller;

import com.example.backend.AbstractRestDocsTest;
import com.example.backend.domain.cardb.dto.CardbResponseDto;
import com.example.backend.domain.cardb.service.CardbService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.restdocs.mockmvc.RestDocumentationRequestBuilders;
import org.springframework.restdocs.payload.JsonFieldType;
import org.springframework.test.web.servlet.ResultActions;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.restdocs.operation.preprocess.Preprocessors.*;
import static org.springframework.restdocs.payload.PayloadDocumentation.fieldWithPath;
import static org.springframework.restdocs.payload.PayloadDocumentation.responseFields;
import static org.springframework.restdocs.request.RequestDocumentation.parameterWithName;
import static org.springframework.restdocs.request.RequestDocumentation.requestParameters;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


//@WebMvcTest(CardbController.class)
@SpringBootTest
class CardbControllerTest extends AbstractRestDocsTest {

    @MockBean
    private CardbService service;

    @Test
    @DisplayName("키워드에 해당하는 설명을 반환해야 한다")
    void shouldReturn200Response() throws Exception {
        when(service.getDescriptionByKeyword(any()))
                .thenReturn(new CardbResponseDto("파워트레인", "토크 어쩌고 저쩌고", "s3 url"));

        ResultActions perform = mockMvc.perform(
                RestDocumentationRequestBuilders.get("/api/v1/cardb")
                        .param("keyword", "zzz")
        );

        perform.andDo(print())
                .andExpect(status().isOk());

        perform.andDo(restDocs.document(
                        "Car DB",
                        preprocessRequest(prettyPrint()),
                        preprocessResponse(prettyPrint()),
                        requestParameters(
                                parameterWithName("keyword").description("백카사전 키워드")
                        ),
                        responseFields(
                                fieldWithPath("code").type(JsonFieldType.NUMBER).description("상태 코드(Http Status 아님)"),
                                fieldWithPath("message").type(JsonFieldType.STRING).description("결과메시지"),
                                fieldWithPath("data").type(JsonFieldType.OBJECT).description("결과 데이터"),
                                fieldWithPath("data.keyword").type(JsonFieldType.STRING).description("백카사전 키워드"),
                                fieldWithPath("data.description").type(JsonFieldType.STRING).description("백카사전 설명"),
                                fieldWithPath("data.imageSrc").type(JsonFieldType.STRING).description("이미지 url")
                        )
                )
        );
    }
}