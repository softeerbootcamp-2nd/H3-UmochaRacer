package com.example.backend.domain.intro.controller;

import com.example.backend.AbstractRestDocsTest;
import com.example.backend.domain.intro.service.ColorService;
import com.example.backend.domain.intro.service.OptionInformationService;
import org.jetbrains.annotations.NotNull;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.restdocs.mockmvc.RestDocumentationRequestBuilders;
import org.springframework.restdocs.payload.JsonFieldType;
import org.springframework.restdocs.payload.ResponseFieldsSnippet;
import org.springframework.restdocs.request.RequestParametersSnippet;
import org.springframework.test.web.servlet.ResultActions;

import static org.springframework.restdocs.operation.preprocess.Preprocessors.*;
import static org.springframework.restdocs.operation.preprocess.Preprocessors.prettyPrint;
import static org.springframework.restdocs.payload.PayloadDocumentation.*;
import static org.springframework.restdocs.request.RequestDocumentation.parameterWithName;
import static org.springframework.restdocs.request.RequestDocumentation.requestParameters;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
class IntroControllerTest extends AbstractRestDocsTest {
    @Mock
    private OptionInformationService optionInformationService;
    @Mock
    private ColorService colorService;
    @InjectMocks
    private IntroController controller;

    @ParameterizedTest
    @ValueSource(strings = {"exterior-color", "interior-color"})
    @DisplayName("트림 별로 선택할 수 있는 색상 정보를 반환한다.")
    void returnColorOptionByTrim(String endpoint) throws Exception {
        ResultActions perform = mockMvc.perform(RestDocumentationRequestBuilders.get("/api/v1/intro/" + endpoint));

        perform.andDo(print())
                .andExpect(status().isOk());

        perform.andDo(restDocs.document(
                        "메인 화면 - 트림 별 색상",
                        preprocessRequest(prettyPrint()),
                        preprocessResponse(prettyPrint()),
                        introControllerResponseFields()
                )
        );
    }

    @NotNull
    private RequestParametersSnippet optionsRequiredQueryParameters() {
        return requestParameters(
                parameterWithName("category").optional().description("옵션 카테고리"),
                parameterWithName("page").description("페이지 시작 정보"),
                parameterWithName("size").optional().description("페이지 크기(기본 5)")
        );
    }

    @NotNull
    private ResponseFieldsSnippet introControllerResponseFields() {
        return responseFields(
                fieldWithPath("code").type(JsonFieldType.NUMBER).description("상태 코드(Http Status 아님)"),
                fieldWithPath("message").type(JsonFieldType.STRING).description("결과메시지"),
                fieldWithPath("data").type(JsonFieldType.ARRAY).description("결과 데이터"),
                fieldWithPath("data[].trim").type(JsonFieldType.STRING).description("트림 이름"),
                fieldWithPath("data[].sources").type(JsonFieldType.ARRAY).description("해당 트림에만 존재하는 옵션"),
                fieldWithPath("data[].sources[].name").type(JsonFieldType.STRING).description("옵션 이름"),
                fieldWithPath("data[].sources[].imageSrc").type(JsonFieldType.STRING).description("이미지 url")
        );
    }
}