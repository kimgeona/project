# 사용자 지정 매크로
PROJECT_REPO=https://github.com/kimgeona/learning_opencv.git	# OpenCV 프로젝트 git 주소 

# 매크로들
PROJECT_NAME=$(basename $(notdir $(PROJECT_REPO)))
CURDIR_WIN=$(subst /,\,$(CURDIR))
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
.PHONY: help check info install project clean_install clean_project

# Makefile 정보 출력
help:
ifeq ($(OS_NAME), MACOS)
	@echo 
	@echo "명령어 도움말"
	@echo ""
	@echo
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo 작성중...
endif

check:
ifeq ($(OS_NAME), MACOS)
	@echo "--"
	@echo "-- make  : $(shell which make)"
	@echo "-- cmake : $(shell which cmake)"
	@echo "-- git   : $(shell which git)"
	@echo "--"
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo --
	@echo -- make  : $(shell where make)
	@echo -- cmake : $(shell where cmake)
	@echo -- git   : $(shell where git)
	@echo --
endif

info:
ifeq ($(OS_NAME), MACOS)
	@echo "--"
	@echo "-- project_opencv : https://github.com/kimgeona/project_opencv.git"
	@echo "-- $(PROJECT_NAME) : $(PROJECT_REPO)"
	@echo "--"
	@echo "-- Writer : "
	@echo "--   Geona Kim
	@echo "--   kimgeona77@gmail.com"
	@echo "--"
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo --
	@echo -- project_opencv : https://github.com/kimgeona/project_opencv.git
	@echo -- $(PROJECT_NAME) : $(PROJECT_REPO)
	@echo --
	@echo -- OpenCV ENV Path : $(CURDIR_WIN)\opencv_install\x64\vc17\bin
	@echo --
	@echo -- Writer : 
	@echo --   Geona Kim
	@echo --   kimgeona77@gmail.com
	@echo --
endif

# OpenCV 라이브러리 설치 및 빌드
install:
ifeq ($(OS_NAME), MACOS)
	@if [ -d opencv ]; \
	then \
		echo "install : 이미 설치된 OpenCV 라이브러리를 사용합니다."; \
	else \
		echo "install : OpenCV 라이브러리를 다운받습니다."; \
		git clone https://github.com/opencv/opencv.git; \
	fi
	@if [ -d opencv_build ]; \
	then \
		echo "install : 이미 빌드된 OpenCV 라이브러리가 존재합니다."; \
	else \
		echo "install : OpenCV 라이브러리를 빌드합니다."; \
		@cmake -GXocde -DBUILD_EXAMPLES=ON -DINSTALL_CREATE_DISTRIB=ON -DCMAKE_INSTALL_PREFIX=.\\opencv_install -S.\\opencv -B.\\opencv_build; \
		cmake --build .\\opencv_build -j7 --config debug; \
		cmake --build .\\opencv_build -j7 --config release; \
		cmake --build .\\opencv_build -j7 --target install --config debug; \
		cmake --build .\\opencv_build -j7 --target install --config release; \
	fi
	@echo "install : 완료."
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@git clone https://github.com/opencv/opencv.git
	@cmake -G"Visual Studio 16 2019" -A x64 -DBUILD_EXAMPLES=ON -DINSTALL_CREATE_DISTRIB=ON -DCMAKE_INSTALL_PREFIX=.\\opencv_install -S.\\opencv -B.\\opencv_build
	@cmake --build .\\opencv_build -j7 --config debug
	@cmake --build .\\opencv_build -j7 --config release
	@cmake --build .\\opencv_build -j7 --target install --config debug
	@cmake --build .\\opencv_build -j7 --target install --config release
	@echo --
	@echo --
	@echo -- !중요!
	@echo -- 환경변수 Path에 $(CURDIR_WIN)\opencv_install\x64\vc17\bin를 추가하세요.
	@echo -- 
	@echo --
endif

# OpenCV 프로젝트 생성
project:
ifeq ($(OS_NAME), MACOS)
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
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@git clone $(PROJECT_REPO)
	@cmake -S.\\$(PROJECT_NAME) -B.\\$(PROJECT_NAME)_build -G "Visual Studio 17 2022" -A x64 -DOpenCV_DIR=..\\opencv_build
endif


# install 관련 파일들 전부 제거
clean_install:
ifeq ($(OS_NAME), MACOS)
	@echo "clean_install : OpenCV 라이브러리를 삭제합니다."
	@rm -rf ./opencv
	@echo "clean_install : OpenCV 라이브러리 빌드를 삭제합니다."
	@rm -rf ./opencv_build
	@echo "clean_install : OpenCV 라이브러리 install을 삭제합니다."
	@rm -rf ./opencv_install
	@echo "clean_install : 완료."
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo clean_install : OpenCV 라이브러리를 삭제합니다.
	@rmdir /s /q .\\opencv
	@echo clean_install : OpenCV 라이브러리 빌드를 삭제합니다.
	@rmdir /s /q .\\opencv_build
	@echo clean_install : OpenCV 라이브러리 install을 삭제합니다.
	@rmdir /s /q .\\opencv_install
	@echo clean_install : 완료.
	@echo --
	@echo --
	@echo -- !알림!
	@echo -- 환경변수 Path에 $(CURDIR_WIN)\opencv_install\x64\vc17\bin를 추가하세요.
	@echo --
	@echo --
endif


# 프로젝트 관련 파일들 전부 제거
clean_project:
ifeq ($(OS_NAME), MACOS)
	@echo "clean_project : $(PROJECT_NAME)를 삭제합니다."
	@rm -rf ./$(PROJECT_NAME)
	@echo "clean_project : $(PROJECT_NAME)_build를 삭제합니다."
	@rm -rf ./$(PROJECT_NAME)_build
	@echo "clean_project : 완료."
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo clean_project : $(PROJECT_NAME)를 삭제합니다.
	@rmdir /s /q .\\$(PROJECT_NAME)
	@echo clean_project : $(PROJECT_NAME)_build를 삭제합니다.
	@rmdir /s /q .\\$(PROJECT_NAME)_build
	@echo clean_project : 완료.
endif
