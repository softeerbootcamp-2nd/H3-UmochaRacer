package com.example.backend.domain.information.controller;

import com.example.backend.AbstractRestDocsTest;
import com.example.backend.domain.global.dto.ResponseDto;
import com.example.backend.domain.information.dto.CommonResponse;
import com.example.backend.domain.information.dto.OptionInformationResponse;
import com.example.backend.domain.information.mapper.InformationMapper;
import com.example.backend.domain.information.model.option.entity.AdditionalOption;
import com.example.backend.domain.information.service.AdditionalOptionService;
import com.example.backend.domain.information.service.strategy.InformationStrategy;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.restdocs.mockmvc.RestDocumentationRequestBuilders;
import org.springframework.restdocs.payload.JsonFieldType;
import org.springframework.test.web.servlet.ResultActions;

import java.util.List;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.springframework.restdocs.operation.preprocess.Preprocessors.*;
import static org.springframework.restdocs.operation.preprocess.Preprocessors.prettyPrint;
import static org.springframework.restdocs.payload.PayloadDocumentation.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
public class AdditonalOptionInformationControllerTest extends AbstractRestDocsTest {
    @Mock
    private InformationStrategy strategyFactory;

    @Mock
    private AdditionalOptionService additionalOptionService;

    @InjectMocks
    private InformationController controller;

    @Test
    @DisplayName("휠 정보를 반환한다")
    void returnInfoAboutWheelOptions() throws Exception {
        ResultActions perform = mockMvc.perform(
                RestDocumentationRequestBuilders.get("/api/v1/info/wheel")
        );
        performOptionInfoTest(perform);
    }

    @Test
    @DisplayName("추가 옵션 정보를 반환한다")
    void returnInfoAboutAdditionalOptions() throws Exception {
//        AdditionalOption option = new AdditionalOption("옵션", "url", 1234, "system");
//        CommonResponse map = new InformationMapper().map(option);
//
//        when(additionalOptionService.getByCategory(anyString()))
//                .thenReturn(List.of(map));

        ResultActions perform = mockMvc.perform(
                RestDocumentationRequestBuilders.get("/api/v1/info/additional-option")
                        .param("category", "performance")
        );
        performOptionInfoTest(perform);
    }

    void performOptionInfoTest(ResultActions perform) throws Exception {
        perform.andDo(print())
                .andExpect(status().isOk());

        perform.andDo(restDocs.document(
                        "휠 / 추가옵션 Information",
                        preprocessRequest(prettyPrint()),
                        preprocessResponse(prettyPrint()),
                        requestFields(

                        ),
                        responseFields(
                                fieldWithPath("code").type(JsonFieldType.NUMBER).description("상태 코드(Http Status 아님)"),
                                fieldWithPath("message").type(JsonFieldType.STRING).description("결과메시지"),
                                fieldWithPath("data").type(JsonFieldType.ARRAY).description("결과 데이터"),
                                fieldWithPath("data[].id").type(JsonFieldType.NUMBER).description("식별 아이디"),
                                fieldWithPath("data[].name").type(JsonFieldType.STRING).description("옵션 이름"),
                                fieldWithPath("data[].imageSrc").type(JsonFieldType.STRING).description("이미지 url"),
                                fieldWithPath("data[].price").type(JsonFieldType.NUMBER).description("옵션 가격"),
                                fieldWithPath("data[].partsSrc").type(JsonFieldType.STRING).optional().description("(N Performance, H Genuine)")
                        )
                )
        );
    }

}
