# 지원 운영체제 : Windows, MacOS

# 생성할 OpenCV 프로젝트 이름
PROJECT_REPO=
PROJECT_NAME=learning_opencv

# 현재 운영체제 확인
OS_NAME =
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
install:
	@echo
	if [ -d opencv ]; \
	then \
		@echo "install : 이미 설치된 OpenCV 라이브러리를 사용합니다."; \
	else \
		@echo "install : OpenCV 라이브러리를 다운받습니다."; \
		@git clone https://github.com/opencv/opencv.git; \
	fi
	if [ -d opencv_build]; \
	then \
		@echo "install : 이미 빌드된 OpenCV 라이브러리가 존재합니다."
	else \
		@echo "install : OpenCV 라이브러리를 빌드합니다."
		@cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=ON -S./opencv -B./opencv_build
		@cmake --build ./opencv_build -j7
	fi
	@echo "install : 완료."

clean_install: 
	@echo
	@echo "clean_install : OpenCV 라이브러리를 삭제합니다."
	@rm -rf ./opencv
	@echo "clean_install : OpenCV 라이브러리 빌드를 삭제합니다."
	@rm -rf ./opencv_build
	@echo "clean_install : 완료."

project:
	@echo
	@echo "project : OpenCV 프로젝트를 생성합니다."
	@git clone [레파지토리]
	@cmake -S./$(PROJECT_NAME) -B./$(PROJECT_NAME)_build -GXcode -DOpenCV_DIR=./opencv_build
	@echo "project : 완료."

clean_project:
	@echo
	@echo "clean_project : $(PROJECT_NAME)를 삭제합니다."
	rm -rf ./$(PROJECT_NAME)
	@echo "clean_project : 완료."


# 2. clear 부분 구현하기 : 현재 Makefile을 제외한 나머지 다 삭제하기
#.PHONY: clear
#clear:
#	rm






