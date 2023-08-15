package com.example.backend.domain.information.controller;

import com.example.backend.AbstractRestDocsTest;
import com.example.backend.domain.information.service.AdditionalOptionService;
import com.example.backend.domain.information.service.strategy.InformationStrategy;
import com.example.backend.domain.information.service.strategy.PowertrainService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.restdocs.mockmvc.RestDocumentationRequestBuilders;
import org.springframework.restdocs.payload.JsonFieldType;
import org.springframework.test.web.servlet.ResultActions;

import static org.springframework.restdocs.operation.preprocess.Preprocessors.*;
import static org.springframework.restdocs.operation.preprocess.Preprocessors.prettyPrint;
import static org.springframework.restdocs.payload.PayloadDocumentation.fieldWithPath;
import static org.springframework.restdocs.payload.PayloadDocumentation.responseFields;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@DisplayName("옵션에 대한 정보")
class CarInformationControllerTest extends AbstractRestDocsTest {
    @Mock
    private InformationStrategy strategyFactory;
    @Mock
    private PowertrainService powertrainService;

    @MockBean
    private AdditionalOptionService additionalOptionService;

    @InjectMocks
    private InformationController controller;

    @ParameterizedTest
    @ValueSource(strings = {"powertrain", "bodytype", "driving-system"})
    void returnInfoAboutVariousOptions(String endpoint) throws Exception {
        performOptionInfoTest(endpoint);
    }

    @DisplayName("옵션에 대한 정보를 반환한다")
    void performOptionInfoTest(String uri) throws Exception {

        ResultActions perform = mockMvc.perform(
                RestDocumentationRequestBuilders.get("/api/v1/info/"+uri)
        );

        perform.andDo(print())
                .andExpect(status().isOk());

        perform.andDo(restDocs.document(
                        "Information",
                        preprocessRequest(prettyPrint()),
                        preprocessResponse(prettyPrint()),
                        responseFields(
                                fieldWithPath("code").type(JsonFieldType.NUMBER).description("상태 코드(Http Status 아님)"),
                                fieldWithPath("message").type(JsonFieldType.STRING).description("결과메시지"),
                                fieldWithPath("data").type(JsonFieldType.ARRAY).description("결과 데이터"),
                                fieldWithPath("data[].id").type(JsonFieldType.NUMBER).description("식별 아이디"),
                                fieldWithPath("data[].name").type(JsonFieldType.STRING).description("옵션 이름"),
                                fieldWithPath("data[].imageSrc").type(JsonFieldType.STRING).description("이미지 url"),
                                fieldWithPath("data[].price").type(JsonFieldType.NUMBER).description("옵션 가격")
                        )
                )
        );
    }
}