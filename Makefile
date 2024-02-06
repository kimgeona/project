# 변수 : 현재 운영체제 정보
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

# 변수 : git 프로젝트 주소
ifeq ($(OS_NAME), MACOS)
PROJECT_REPO=$(subst .makefile_config:PROJECT_REPO=,,$(shell grep -r "PROJECT_REPO=" .makefile_config))
endif
ifeq ($(OS_NAME), WIN32)
PROJECT_REPO=$(subst PROJECT_REPO=,,$(shell findstr "PROJECT_REPO=" .makefile_config))
endif

# 변수 : git 프로젝트 이름
PROJECT_NAME=$(basename $(notdir $(PROJECT_REPO)))

# 변수 : CURDIR 윈도우 주소 형식
CURDIR_WIN=$(subst /,\,$(CURDIR))


.PHONY: create_config update_config help check info install install_opencv project clean_install clean_project

# .makefile_config 없으면 생성하기
create_config:
ifeq ($(wildcard .makefile_config),)
ifeq ($(OS_NAME), MACOS)
	@echo "PROJECT_REPO=https://github.com/kimgeona/project_template.git \n" > .makefile_config
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo PROJECT_REPO=https://github.com/kimgeona/project_template.git > .makefile_config
endif
endif

# Makefile 변수 저장하기
update_config: create_config
ifeq ($(OS_NAME), MACOS)
	@echo "PROJECT_REPO=$(PROJECT_REPO) \n" > .makefile_config
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo PROJECT_REPO=$(PROJECT_REPO) > .makefile_config
endif

# 도움말 출력
help: update_config
ifeq ($(OS_NAME), MACOS)
	@echo
	@echo "사용 예시:"
	@echo "  make 명령어"
	@echo 
	@echo "명령어 종류:"
	@echo "  make help              : 도움말"
	@echo "  make check             : 설치되어야 하는 프로그램들을 확인"
	@echo "  make info              : 해당 Makefile와 설치 관련 정보들"
	@echo "  make install           : 지원되는 최신 C/C++ 라이브러리 전부 설치"
	@echo "  make install_opencv    : 최신의 OpenCV 라이브러리 설치"
	@echo "  make clean_opencv      : 설치된 OpenCV 라이브러리 제거"
	@echo "  make project           : git 프로젝트를 불러오고 각각의 운영체제에 맞는 IDE 프로젝트를 생성"
	@echo "  make clean_project     : git 프로젝트를 제거합니다"
	@echo 
	@echo "주의 사항:"
	@echo "  * 현재 Makefile이 담겨져 있는 폴더의 디렉토리가 변경되면 안됨.(이름 포함)"
	@echo "  * 현재 Makefile로 생성된 라이브러리들과 프로젝트는 가능한 제공되는 명령어로의 접근을 우선적으로 고려할 것."
	@echo "  * Windows 운영영체제는 라이브러리 설치 완료 후 환경변수 설정에 유의해 주세요. 환경변수에 대한 설정은 make info 명령어를 통해 다시 확인할 수 있습니다."
	@echo
	@echo "추가적인 도움말:"
	@echo "  https://github.com/kimgeona/project"
	@echo
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo _
	@echo 사용 예시:
	@echo   make 명령어
	@echo _
	@echo 명령어 종류:
	@echo   make help              : 도움말
	@echo   make check             : 설치되어야 하는 프로그램들을 확인
	@echo   make info              : 해당 Makefile와 설치 관련 정보들
	@echo   make install           : 지원되는 최신 C/C++ 라이브러리 전부 설치
	@echo   make install_opencv    : 최신의 OpenCV 라이브러리 설치
	@echo   make clean_opencv      : 설치된 OpenCV 라이브러리 제거
	@echo   make project           : git 프로젝트를 불러오고 각각의 운영체제에 맞는 IDE 프로젝트를 생성
	@echo   make clean_project     : git 프로젝트를 제거합니다
	@echo _
	@echo 주의 사항:
	@echo   * 현재 Makefile이 담겨져 있는 폴더의 디렉토리가 변경되면 안됨.(이름 포함)
	@echo   * 현재 Makefile로 생성된 라이브러리들과 프로젝트는 가능한 제공되는 명령어로의 접근을 우선적으로 고려할 것.
	@echo   * Windows 운영영체제는 라이브러리 설치 완료 후 환경변수 설정에 유의해 주세요. 환경변수에 대한 설정은 make info 명령어를 통해 다시 확인할 수 있습니다.
	@echo _
	@echo 추가적인 도움말:
	@echo   https://github.com/kimgeona/project
	@echo .
endif

# 설치 확인
check: update_config
ifeq ($(OS_NAME), MACOS)
	@echo
	@echo "  make  : $(shell which make)"
	@echo "  cmake : $(shell which cmake)"
	@echo "  git   : $(shell which git)"
	@echo
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo   _
	@echo   make  : $(shell where make)
	@echo   cmake : $(shell where cmake)
	@echo   git   : $(shell where git)
	@echo .
endif

info: update_config
ifeq ($(OS_NAME), MACOS)
	@echo
	@echo "  PROJECT_REPO : $(PROJECT_REPO)"
	@echo
	@echo "  Writer : "
	@echo "    Geona Kim"
	@echo "    kimgeona77@gmail.com"
	@echo "    https://github.com/kimgeona/project.git"
	@echo
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo   _
	@echo   PROJECT_REPO : $(PROJECT_REPO)
	@echo   _
	@echo   OpenCV Path : $(shell dir /s /b /ad $(CURDIR_WIN)\opencv_install\x64\bin | findstr "vc*")
	@echo   _
	@echo   Writer : 
	@echo     Geona Kim
	@echo     kimgeona77@gmail.com
	@echo     https://github.com/kimgeona/project.git
	@echo .
endif

# 지원되는 라이브러리 전체 다운 및 빌드
install: update_config install_opencv

# OpenCV 라이브러리 설치 및 빌드
install_opencv: update_config
ifeq ($(OS_NAME), MACOS)
	@if [ -d opencv ]; then \
		echo "install : 이미 설치된 OpenCV 라이브러리를 사용합니다."; \
	else \
		echo "install : OpenCV 라이브러리를 다운받습니다." \
		&& git clone https://github.com/opencv/opencv.git; \
	fi
	@if [ -d opencv_build ]; then \
		echo "install : 이미 빌드된 OpenCV 라이브러리가 존재합니다."; \
	else \
		(\
		echo "install : OpenCV 라이브러리를 빌드합니다." \
		&& mkdir opencv_build \
		&& cmake -GXcode -DBUILD_EXAMPLES=ON -DCMAKE_INSTALL_PREFIX=./opencv_install -S./opencv -B./opencv_build \
		&& cmake --build ./opencv_build -j7 --config debug \
		&& cmake --build ./opencv_build -j7 --config release \
		&& cmake --build ./opencv_build -j7 --target install --config debug \
		&& cmake --build ./opencv_build -j7 --target install --config release \
		&& echo "install : 완료." \
		)\
		|| (\
		echo "install : OpenCV 라이브러리 빌드에 실패했습니다. 빌드 전으로 되돌립니다." \
		&& rm -rf ./opencv_build \
		&& rm -rf ./opencv_install \
		);\
	fi
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@if exist opencv (\
		echo install : 이미 설치된 OpenCV 라이브러리를 사용합니다. \
	)\
	else (\
		echo install : OpenCV 라이브러리를 다운받습니다. \
		&& git clone https://github.com/opencv/opencv.git \
	)
	@if exist opencv_build (\
		echo install : 이미 빌드된 OpenCV 라이브러리가 존재합니다. \
	)\
	else (\
		(\
		echo install : OpenCV 라이브러리를 빌드합니다.. \
		&& cmake -G "Visual Studio 17 2022" -A x64 -DBUILD_EXAMPLES=ON -DINSTALL_CREATE_DISTRIB=ON -DCMAKE_INSTALL_PREFIX=.\\opencv_install -S.\\opencv -B.\\opencv_build \
		&& cmake --build .\\opencv_build -j7 --config debug \
		&& cmake --build .\\opencv_build -j7 --config release \
		&& cmake --build .\\opencv_build -j7 --target install --config debug \
		&& cmake --build .\\opencv_build -j7 --target install --config release \
		&& echo -- \
		&& echo -- \
		&& echo -- !중요! \
		&& echo -- 환경변수 Path에 $(shell dir /s /b /ad $(CURDIR_WIN)\opencv_install\x64\bin | findstr "vc*")를 추가하세요. \
		&& echo -- \
		&& echo -- \
		&& echo install : 완료. \
		)\
		|| (\
		echo install : OpenCV 라이브러리 빌드에 실패했습니다. 빌드 전으로 되돌립니다. \
		&& if exist .\opencv_build rmdir /s /q .\opencv_build \
		&& if exist .\opencv_install rmdir /s /q .\opencv_install \
		)\
	)
endif

# OpenCV 프로젝트 생성
project: update_config
ifeq ($(OS_NAME), MACOS)
	@if [ -d $(PROJECT_NAME) ]; then \
		echo "project : 프로젝트 $(PROJECT_NAME)가 이미 존재합니다."; \
	else \
		echo "project : 프로젝트 $(PROJECT_NAME)를 git clone 합니다." \
		&& git clone $(PROJECT_REPO); \
	fi
	@if [ -d $(PROJECT_NAME)/build ]; then \
		echo "project : 프로젝트 $(PROJECT_NAME)_build가 이미 존재합니다."; \
	else \
		(\
		echo "project : 프로젝트 $(PROJECT_NAME)를 빌드 합니다." \
		&& cmake -S./$(PROJECT_NAME) -B./$(PROJECT_NAME)/build -GXcode -DOpenCV_DIR=../opencv_build \
		&& echo "project : 완료." \
		)\
		|| (\
		echo "project : 프로젝트 $(PROJECT_NAME) 빌드에 실패했습니다. 빌드 전으로 되돌립니다." \
		&& rm -rf ./$(PROJECT_NAME) \
		);\
	fi
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@if exist $(PROJECT_NAME) (\
		echo project : 프로젝트 $(PROJECT_NAME)가 이미 존재합니다. \
	)\
	else (\
		echo project : 프로젝트 $(PROJECT_NAME)를 git clone 합니다. \
		&& git clone $(PROJECT_REPO) \
	)
	@if exist $(PROJECT_NAME)\\build (\
		echo project : 프로젝트 $(PROJECT_NAME)_build가 이미 존재합니다. \
	)\
	else (\
		(\
		echo project : 프로젝트 $(PROJECT_NAME)를 빌드 합니다. \
		&& cmake -S.\\$(PROJECT_NAME) -B.\\$(PROJECT_NAME)\\build -G "Visual Studio 17 2022" -A x64 -DOpenCV_DIR=..\\opencv_build \
		)
		|| (\
		echo project : 프로젝트 $(PROJECT_NAME) 빌드에 실패했습니다. 빌드 전으로 되돌립니다. \
		&& if exist .\$(PROJECT_NAME) rmdir /s /q .\$(PROJECT_NAME) \
		)\
	)
endif


# install 관련 파일들 전부 제거
clean_opencv: update_config
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
clean_project: update_config
ifeq ($(OS_NAME), MACOS)
	@echo "clean_project : $(PROJECT_NAME)를 삭제합니다."
	@rm -rf ./$(PROJECT_NAME)
	@echo "clean_project : 완료."
endif
ifeq ($(OS_NAME), WIN32)
	@chcp 65001
	@echo clean_project : $(PROJECT_NAME)를 삭제합니다.
	@if exist .\$(PROJECT_NAME) rmdir /s /q .\$(PROJECT_NAME)
	@echo clean_project : 완료.
endif
