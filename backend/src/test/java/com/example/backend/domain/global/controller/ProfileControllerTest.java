package com.example.backend.domain.global.controller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.mock.env.MockEnvironment;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

class ProfileControllerTest {
    private ProfileController controller;
    private MockEnvironment env;

    @BeforeEach
    void setUp() {
        env = new MockEnvironment();
    }

    @Test
    @DisplayName("실행 중인 Profile을 반환한다")
    void testProdProfile() {
        //given
        String expectedProfile = "prod1";
        env.addActiveProfile(expectedProfile);
        env.addActiveProfile("prod2");
        env.addActiveProfile("prod3");

        controller = new ProfileController(env);

        //when
        String profile = controller.profile();

        //then
        assertThat(profile).isEqualTo(expectedProfile);
    }

    @Test
    @DisplayName("prod profile이 있으면 첫 번째가 조회된다")
    public void getFirstWhenProdExist() {
        //given
        String expectedProfile = "prod";
        MockEnvironment env = new MockEnvironment();

        env.addActiveProfile(expectedProfile);
        env.addActiveProfile("abcd");

        ProfileController controller = new ProfileController(env);

        //when
        String profile = controller.profile();

        //then
        assertThat(profile).isEqualTo(expectedProfile);
    }

    @Test
    @DisplayName("active profile이 없으면 default가 조회된다")
    public void whenProdNotExist() {
        //given
        String expectedProfile = "default";
        MockEnvironment env = new MockEnvironment();
        ProfileController controller = new ProfileController(env);

        //when
        String profile = controller.profile();

        //then
        assertThat(profile).isEqualTo(expectedProfile);
    }
}