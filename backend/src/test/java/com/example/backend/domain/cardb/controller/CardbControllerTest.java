package com.example.backend.domain.cardb.controller;

import com.example.backend.domain.cardb.dto.CardbResponseDto;
import com.example.backend.domain.cardb.repository.CardbRepository;
import com.example.backend.domain.cardb.service.CardbService;
import com.example.backend.utils.AbstractRestDocsTest;
import com.example.backend.utils.RestDocsConfiguration;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.restdocs.payload.JsonFieldType;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.restdocs.payload.PayloadDocumentation.fieldWithPath;
import static org.springframework.restdocs.payload.PayloadDocumentation.responseFields;
import static org.springframework.restdocs.request.RequestDocumentation.parameterWithName;
import static org.springframework.restdocs.request.RequestDocumentation.requestParameters;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@Import(RestDocsConfiguration.class)
@WebMvcTest(CardbController.class)
class CardbControllerTest extends AbstractRestDocsTest {

    @MockBean
    private CardbService service;
    @MockBean
    private CardbRepository repository;

    @Test
    @DisplayName("키워드에 해당하는 설명을 반환해야 한다")
    void shouldReturn200Response() throws Exception {
        when(service.getDescriptionByKeyword(any()))
                .thenReturn(new CardbResponseDto("파워트레인", "토크 어쩌고 저쩌고", "s3 url"));

        mockMvc.perform(get("/api/v1/cardb")
                        .param("keyword", "zzz")
                )
                .andExpect(status().isOk())
                .andDo(print())
                .andDo(restDocs.document(
                            requestParameters(
                                    parameterWithName("keyword").description("백카사전 키워드")
                            ),
                                responseFields(
                                        fieldWithPath("code").type(JsonFieldType.NUMBER).description("상태 코드(Http Status 아님)"),
                                        fieldWithPath("message").type(JsonFieldType.STRING).description("결과메시지"),
                                        fieldWithPath("data").type(JsonFieldType.OBJECT).description("결과 데이"),
                                        fieldWithPath("data.keyword").type(JsonFieldType.STRING).description("백카사전 키워드"),
                                        fieldWithPath("data.description").type(JsonFieldType.STRING).description("백카사전 설명"),
                                        fieldWithPath("data.imageSrc").type(JsonFieldType.STRING).description("이미지 url")
                                )
                        )
                );
    }
}