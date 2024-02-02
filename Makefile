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

.PHONY: help check info install project clean_install clean_project

# 도움말 출력
help:
ifeq ($(OS_NAME), MACOS)
	@echo
	@echo "사용 예시:"
	@echo "  make 명령어"
	@echo 
	@echo "명령어 종류:"
	@echo "  make help              : 도움말"
	@echo "  make check             : 설치되어야 하는 프로그램들을 확인"
	@echo "  make info              : 해당 Makefile와 설치 관련 정보들"
	@echo "  make install_opencv    : 최신의 OpenCV 라이브러리 설치"
	@echo "  make clean_opencv      : 설치된 OpenCV 라이브러리 제거"
	@echo "  make project           : git 프로젝트를 불러오고 각각의 운영체제에 맞는 IDE 프로젝트를 생성"
	@echo "  make clean_project     : git 프로젝트를 제거합니다"
	@echo 
	@echo "주의 사항:"
	@echo "  Windows 운영영체제는 라이브러리 설치 완료 후 환경변수 설정에 유의해 주세요. 환경변수에 대한 설정은 make info 명령어를 통해 다시 확인할 수 있습니다."
	@echo
	@echo "추가적인 도움말:"
	@echo "  https://github.com/kimgeona/project"
	@echo
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo.
	@echo 사용 예시:
	@echo   make 명령어
	@echo.
	@echo 명령어 종류:
	@echo   make help              : 도움말
	@echo   make check             : 설치되어야 하는 프로그램들을 확인
	@echo   make info              : 해당 Makefile와 설치 관련 정보들
	@echo   make install_opencv    : 최신의 OpenCV 라이브러리 설치
	@echo   make clean_opencv      : 설치된 OpenCV 라이브러리 제거
	@echo   make project           : git 프로젝트를 불러오고 각각의 운영체제에 맞는 IDE 프로젝트를 생성
	@echo   make clean_project     : git 프로젝트를 제거합니다
	@echo.
	@echo 주의 사항:
	@echo   Windows 운영영체제는 라이브러리 설치 완료 후 환경변수 설정에 유의해 주세요. 환경변수에 대한 설명은 make info 명령어를 통해 다시 확인할 수 있습니다.
	@echo.
	@echo 추가적인 도움말:
	@echo   https://github.com/kimgeona/project
	@echo.
endif

# 설치 확인
check:
ifeq ($(OS_NAME), MACOS)
	@echo
	@echo "  make  : $(shell which make)"
	@echo "  cmake : $(shell which cmake)"
	@echo "  git   : $(shell which git)"
	@echo
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo.
	@echo   make  : $(shell where make)
	@echo   cmake : $(shell where cmake)
	@echo   git   : $(shell where git)
	@echo.
endif

info:
ifeq ($(OS_NAME), MACOS)
	@echo
	@echo "  project_opencv : https://github.com/kimgeona/project_opencv.git"
	@echo "  $(PROJECT_NAME) : $(PROJECT_REPO)"
	@echo
	@echo "  Writer : "
	@echo "    Geona Kim"
	@echo "    kimgeona77@gmail.com"
	@echo
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo.
	@echo   project_opencv : https://github.com/kimgeona/project_opencv.git
	@echo   $(PROJECT_NAME) : $(PROJECT_REPO)
	@echo.
	@echo   OpenCV Path : $(shell dir /s /b /ad $(CURDIR_WIN)\opencv_install\x64\bin | findstr "vc*")
	@echo.
	@echo   Writer : 
	@echo     Geona Kim
	@echo     kimgeona77@gmail.com
	@echo.
endif

# OpenCV 라이브러리 설치 및 빌드
install_opencv:
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
		mkdir opencv_build; \
		cmake -GXcode -DBUILD_EXAMPLES=ON -DCMAKE_INSTALL_PREFIX=./opencv_install -S./opencv -B./opencv_build; \
		cmake --build ./opencv_build -j7 --config debug; \
		cmake --build ./opencv_build -j7 --config release; \
		cmake --build ./opencv_build -j7 --target install --config debug; \
		cmake --build ./opencv_build -j7 --target install --config release; \
	fi
	@echo "install : 완료."
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@if exist opencv ( \
		echo install : 이미 설치된 OpenCV 라이브러리를 사용합니다. \
	) else ( \
		echo install : OpenCV 라이브러리를 다운받습니다. & \
		git clone https://github.com/opencv/opencv.git \
	)
	@if exist opencv_build ( \
		echo install : 이미 빌드된 OpenCV 라이브러리가 존재합니다. \
	) else ( \
		echo install : OpenCV 라이브러리를 빌드합니다.. & \
		cmake -G"Visual Studio 16 2019" -A x64 -DBUILD_EXAMPLES=ON -DINSTALL_CREATE_DISTRIB=ON -DCMAKE_INSTALL_PREFIX=.\\opencv_install -S.\\opencv -B.\\opencv_build & \
		cmake --build .\\opencv_build -j7 --config debug & \
		cmake --build .\\opencv_build -j7 --config release & \
		cmake --build .\\opencv_build -j7 --target install --config debug & \
		cmake --build .\\opencv_build -j7 --target install --config release & \
		echo -- & \
		echo -- & \
		echo -- !중요! & \
		echo -- 환경변수 Path에 $(shell dir /s /b /ad $(CURDIR_WIN)\opencv_install\x64\bin | findstr "vc*")를 추가하세요. & \
		echo -- & \
		echo -- \
	)
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
	@if exist $(PROJECT_NAME) ( \
		echo project : 프로젝트 $(PROJECT_NAME)가 이미 존재합니다. \
	) else ( \
		echo project : 프로젝트 $(PROJECT_NAME)를 git clone 합니다. & \
		git clone $(PROJECT_REPO) \
	)
	@if exist $(PROJECT_NAME)_build ( \
		echo project : 프로젝트 $(PROJECT_NAME)_build가 이미 존재합니다. \
	) else ( \
		echo project : 프로젝트 $(PROJECT_NAME)를 빌드 합니다. & \
		cmake -S.\\$(PROJECT_NAME) -B.\\$(PROJECT_NAME)_build -G "Visual Studio 17 2022" -A x64 -DOpenCV_DIR=..\\opencv_build \
	)
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
	@if exist .\opencv rmdir /s /q .\opencv
	@echo clean_install : OpenCV 라이브러리 빌드를 삭제합니다.
	@if exist .\opencv_build rmdir /s /q .\opencv_build
	@echo clean_install : OpenCV 라이브러리 install을 삭제합니다.
	@if exist .\opencv_install rmdir /s /q .\opencv_install
	@echo clean_install : 완료.
	@echo --
	@echo --
	@echo -- !알림!
	@echo -- 환경변수 Path에 $(shell dir /s /b /ad $(CURDIR_WIN)\opencv_install\x64\bin | findstr "vc*")를 제거하세요.
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
	@if exist .\$(PROJECT_NAME) rmdir /s /q .\$(PROJECT_NAME)
	@echo clean_project : $(PROJECT_NAME)_build를 삭제합니다.
	@if exist .\$(PROJECT_NAME)_build rmdir /s /q .\$(PROJECT_NAME)_build
	@echo clean_project : 완료.
endif
