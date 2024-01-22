# project
Install the latest C/C++ library and build IDE project with one makefile.   
하나의 Makefile로 C/C++ 라이브러리 설치 및 빌드와 IDE 프로젝트 생성.   

The Makefile currently in the repository automatically creates an IDE project by downloading and building the latest OpenCV library.   
This Makefile is currently in the process of being written and is a version that is clearly supported by Xcode on MacOS.   
I'll commit it as soon as possible to get it running cleanly on Windows as well.   
현재 레파지토리에있는 Makefile은 최신 OpenCV라이브러리를 다운받고 빌드하여 자동으로 IDE 프로젝트를 생성해줍니다.   
현재 해당 Makefile은 작성 과정 중에 있고 MacOS의 Xcode에서 확실하게 지원되는 버전입니다.   
가능한 빨리 Windows에서도 깔끔하게 작동이 가능하도록 커밋할 예정입니다.   
   
Thank you.   
감사합니다.   

# How to execute(실행 방법)
To use it, enter it in the following order:   
$ make install   
$ make project   

사용하기 위해 다음과 같은 순서로 입력하세요:   
$ make install   
$ make project   

# Command Description(명령어 설명)
make install : Download the latest OpenCV library and build it for use. (It takes a lot of time to build the library. If the file already exists, it is skipped.)   
make project : Download the repository written in the Makefile and build the project.   
make clear_install : Delete all files related to the command install.   
make clear_project : Delete all files related to the command project.   
   
make install : 최신 OpenCV 라이브러리를 다운받고 이를 사용 가능하도록 빌드합니다. (라이브러리를 빌드하느라 시간이 좀 많이 걸림, 이미 존재하는 파일이라면 건너뜀.)   
make project : Makefile에 작성되어있는 레파지토리를 다운받아 프로젝트를 빌드해줌.   
make clear_install : install 명령어 관련 파일 전부 삭제.   
make clear_project : project 명령어 관련 파일 전부 삭제.   
