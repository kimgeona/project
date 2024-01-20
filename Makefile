# 사용자 지정 매크로
PROJECT_REPO=https://github.com/kimgeona/learning_opencv.git	# OpenCV 프로젝트 git 주소 

# 매크로들
PROJECT_NAME=$(basename $(notdir $(PROJECT_REPO)))
OS_NAME =

# 현재 운영체제 확인
ifeq ($(OS), Windows_NT)
	OS_NAME = WIN32
else
	OS_NAME = $(shell uname)
	ifeq ($(OS_NAME), Linux)
		OS_NAME = LINUX
	endif
	ifeq ($(OS_NAME), Darwin)
		OS_NAME = MACOS
	endif
endif

# OpenCV 프로젝트 생성
.PHONY: info install project clean_install clean_project

# Makefile 정보 출력
info:
	@echo
	@echo "-- project_opencv --"
	@echo "-- Geona Kim, kimgeona77@gmail.com --"
	@echo

# OpenCV 라이브러리 설치 및 빌드
install:
	@if [ -d opencv ]; \
	then \
		echo "install : 이미 설치된 OpenCV 라이브러리를 사용합니다."; \
	else \
		echo "install : OpenCV 라이브러리를 다운받습니다."; \
		git clone https://github.com/opencv/opencv.git; \
	fi
	@if [ -d opencv_build]; \
	then \
		echo "install : 이미 빌드된 OpenCV 라이브러리가 존재합니다."; \
	else \
		echo "install : OpenCV 라이브러리를 빌드합니다."; \
		cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=ON -S./opencv -B./opencv_build; \
		cmake --build ./opencv_build -j7; \
	fi
	@echo "install : 완료."

# OpenCV 프로젝트 생성
project:
	@if [ -d $(PROJECT_NAME) ]; \
	then \
		echo "project : 프로젝트 $(PROJECT_NAME)가 이미 존재합니다."; \
	else \
		echo "project : 프로젝트 $(PROJECT_NAME)를 git clone 합니다."; \
		git clone $(PROJECT_REPO); \
	fi
	@if [ -d $(PROJECT_NAME)_build ]; \
	then \
		echo "project : 프로젝트 $(PROJECT_NAME)_build가 이미 존재합니다."; \
	else \
		echo "project : 프로젝트 $(PROJECT_NAME)를 빌드 합니다."; \
		cmake -S./$(PROJECT_NAME) -B./$(PROJECT_NAME)_build -GXcode -DOpenCV_DIR=../opencv_build; \
	fi
	@echo "project : 완료."

# install 관련 파일들 전부 제거
clean_install: 
	@echo "clean_install : OpenCV 라이브러리를 삭제합니다."
	@rm -rf ./opencv
	@echo "clean_install : OpenCV 라이브러리 빌드를 삭제합니다."
	@rm -rf ./opencv_build
	@echo "clean_install : 완료."

# 프로젝트 관련 파일들 전부 제거
clean_project:
	@echo "clean_project : $(PROJECT_NAME)를 삭제합니다."
	@rm -rf ./$(PROJECT_NAME)
	@echo "clean_project : $(PROJECT_NAME)_build를 삭제합니다."
	@rm -rf ./$(PROJECT_NAME)_build
	@echo "clean_project : 완료."
