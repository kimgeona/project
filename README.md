# project
"project"는 MacOS와 Windows 환경에서의 C/C++ 라이브러리 사용과 git, github을 이용한 협업을 원활하게 하기 위해 만들어진 Makefile입니다. 해당 Makefile은 간단한 명령어로 같이 협업을 하기 위한 복잡한 환경 세팅을 자동화하는 것을 목표로 하고 있습니다.

해당 Makefile은 크게 "make install"과 "make project" 명령어를 통해 동작합니다. 해당 명령어를 입력하면 현재 자신의 운영체제에 맞는 C/C++ 라이브러리를 자동으로 다운 및 빌드 하여 사용할 수 있게끔 설치해 주고 해당 라이브러리를 이용하여 프로젝트를 수행할 수 있도록 각 운영체제마다 대표적인 IDE 프로젝트를 생성해 줍니다.

>지원 라이브러리 : OpenCV   
>운영체제(IDE) : MacOS(Xcode), Windows(VisualStudio2022)

## 준비
해당 Makefile을 사용하기 위해 우선적으로 준비되어야 하는 프로그램들은 git, make, cmake입니다. 해당 프로그램들을 먼저 설치하시고 사용해 주시기 바랍니다. MacOS는 homebrew를 Windows에는 winget을 이용하시면 편리하게 설치하실 수 있습니다.


## 사용 방법
우선 원하는 디렉토리로 이동 후 아래와 같은 명령어를 입력합니다.

>현재 디렉토리에 git clone을 하고 나중에 "make install"을 하면 해당 디렉토리는 고정적으로 사용해야 하니 신중히 생각해 주세요.(라이브러리가 해당 디렉토리를 기준으로 빌드 되기 때문.)

    $ git clone https://github.com/kimgeona/project.git

위 명령어를 입력하면 해당 디렉토리에는 Makefile과 그 외에 파일들이 들어있을 것입니다. 여기서 중요한 것은 바로 이 Makefile입니다. "project"는 해당 Makefile을 이용하여 라이브러리를 설치하고 프로젝트 빌드까지 완료하도록 자동화되어 있습니다. 우리는 단순히 이 Makefile에 정의되어 있는 명령어를 실행시키기만 하면 됩니다. 방법은 다음과 같습니다.

    $ make install_opencv
    $ make project        # 옵션 : PROJECT_REPO=github_cmake_프로젝트_레파지토리

"make install"은 특정한 라이브러리를 다운로드하고 설치해 주는 명령어입니다. 해당 명령어가 실행되면 Makefile을 가지고 있는 디렉토리는 고정적으로 사용해야 합니다. (그리고 라이브러리 자체를 컴퓨터 시스템에 맞게 빌드 하기 때문에 시간이 좀 많이 걸리므로 커피 한잔하고 오는 것을 추천합니다.)

> 윈도 운영체제는 환경 변수 설정을 해줘야 하니 해당 명령어 사용 후 나오는 라이브러리 주소를 환경 변수에 등록해 주시길 바랍니다. 환경 변수 위치를 그냥 지나쳐 버렸다면 "make info" 명령어 입력을 통해 다시 확인하실 수 있습니다.

"make project"는 해당 makefile에서 지정된 git 레파지토리를 자동으로 clone 하고 cmake를 이용하여 IDE 프로젝트로 빌드 해줍니다. git 레파지토리는 PROJECT_REPO 인자값으로 쉽게 변경할 수 있습니다. (공백 없이 입력, 지정하지 않으면 기본 제공되는 레파지토리로 clone됨.)

이렇게 총 두 단계의 명령어를 거치면 자신의 운영체제에 맞는 C/C++ 라이브러리를 빌드 및 설치해 주고 이를 이용한 IDE 프로젝트까지 생성하여 줍니다. 이게 전부입니다!

## 명령어
Makefile로 사용할 수 있는 명령어는 다음과 같습니다.

    $ make help              # 도움말
    $ make check             # 설치되어야 하는 프로그램들을 확인
    $ make info              # 해당 Makefile와 설치 관련 정보들
    $ make install           # 지원되는 최신 C/C++ 라이브러리 전부 설치
    $ make install_opencv    # 최신의 OpenCV 라이브러리 설치
	$ make clean_opencv      # 설치된 OpenCV 라이브러리 제거
	$ make project           # git 프로젝트를 불러오고 각각의 운영체제에 맞는 IDE 프로젝트를 생성
	$ make clean_project     # git 프로젝트를 제거합니다

명령어들에 대한 설명은 다음과 같습니다.

    # 기타 명령어

    $ make help
    : Makefile에서 현재 정의된 명령어에 대한 간략한 설명을 출력합니다.   

    $ make check
    : Makefile을 실행을 위한 의존성 프로그램들의 위치를 표시합니다. 만약 각 의존성 프로그램의 주소가 표시되지 않는다면 해당 프로그램이 설치되어 있는지를 다시 확인해 주시기를 바랍니다.

    $ make info
    : Makefile을 이용하여 설치된 라이브러리들의 환경변수 주소 정보(윈도우 한정)와 작성자 정보와 같은 간략한 정보가 적혀 있습니다.


    # 핵심 명령어

    $ make install
    : 현재 Makefile에서 지원하는 라이브러리들을 Makefile이 있는 디렉토리에 설치합니다.

    $ make install_opencv
    : 최신의 OpenCV 라이브러리를 Makefile이 있는 디렉토리에 설치합니다.
    : 설치가 완료되면 opencv, opencv_build, opencv_install 폴더에 해당 opencv 관련 라이브러리 파일이 저장됩니다.
    : opencv, opencv_build, opencv_install 폴더가 이미 존재한다면 해당 설치는 건너뜁니다.

    $ make project
    : Makefile을 열어보면 가장 위에 PROJECT_REPO 변수에 작성되어 있는 git 레파지토리를 clone 하고 cmake를 이용하여 IDE 프로젝트를 생성합니다.
    : git clone이 완료되면 <레파지토리이름>, <레파지토리이름_build> 폴더가 생성됩니다.
    : <레파지토리이름>, <레파지토리이름_build> 폴더가 이미 존재한다면 프로젝트 생성을 위한 작업은 건너뜁니다.
    : PROJECT_REPO 변숫값에는 다른 레파지토리를 적어주어도 됩니다. 단 cmake를 이용하여 프로젝트를 구성할 수 있는 레파지토리이어야 합니다.


    # 삭제 관련 명령어

    $ make clean_opencv
    : Makefile이 있는 디렉토리에 설치된 OpenCV 라이브러리를 제거합니다.
    : 단순히 opencv, opencv_build, opencv_install 폴더가 제거되는 방식입니다.

    $ make clean_project
    : Makefile이 있는 디렉토리에 git clone 된 프로젝트 관련 파일을 전부 제거합니다.
    : 단순히 <레파지토리이름>, <레파지토리이름_build> 폴더가 제거되는 방식입니다.

## uninstall
현재 작업 중인 프로젝트와 설치된 라이브러리들을 제거하고 싶으시다면 단순히 git clone을 통해 받으신 Makefile이 담겨 있는 폴더를 삭제하면 됩니다. 해당 Makefile을 통해 설치한 라이브러리들과 생성한 프로젝트 파일들은 전부 Makefile과 동일한 디렉토리에 설치되며 이를 제거하는 것만으로도 간단히 해당 Makefile을 사용하기 전과 같은 초기 상태로 되돌리실 수 있습니다.

>단 Windows에서는 라이브러리 설치 시 등록하였던 환경 변수를 직접 삭제해 주셔야 합니다. 해당 값은 "make info" 명령어를 통해 확인 가능합니다.

## 문제해결
(Windows) 검색 데이터베이스와 IntelliSense 파일을 저장 관련 문제 :
>비주얼 스튜디오에서는 자동완성기능(IntelliSense)에 대한 데이터베이스를 생성하여 사용자가 함수나 변수등을 입력할때 자동완성을 제공합니다. 하지만 이 검색 데이터베이스는 비주얼 스튜디오가 아닌 외부로부터 소스파일의 이름을 수정하게 되면 새로운 소스에 대한 인식을 제대로 하지 못하는 문제를 발생시킬 수 있고 이는 비주얼 스튜디오가 대체(fallback) 위치로 해당 데이터베이스를 저장할 것을 권고하게 됩니다. 만일 이런 상황이 발생한다면 해당 경고창의 취소 버튼을 누르고 현재 프로젝트를 삭제하고 다시 설치해주시는 것으로 간단하게 해결하실 수 있습니다.

(Windows) opencv의 dll 파일들을 찾을 수 없는 문제 :
> windows에서 opencv는 라이브러리를 dll 형태로 저장하여 사용합니다. 하지만 이 dll의 위치가 환경변수 Path에 등록이 되지 않는다면 현재 프로젝트에서 opencv 라이브러리 사용에 대한 문제가 나타날 것 입니다. 이는 make info 명령어를 입력하면 표시되는 OpenCV Path 를 환경변수에 등록해주시는 것으로 해결할 수 있습니다.

(windosw) opencv 라이브러리를 빌드할 수 없는 문제 : 
> OpenCV를 제공되는 명령어로 빌드하려면 make install_opencv 명령어를 입력하면 됩니다. 하지만 이와 같은 빌드가 제대로 수행되지 않는 경우가 있습니다. 바로 make, cmake의 설치가 제대로 되어 있지 않는 경우입니다. 해당 설치 확인은 make check 라는 명령어를 통해 위치를 쉽게 확인하실 수 있고, 설치되어 있는 프로그램이 시스템 또는 사용자에서 공통적으로 사용되고 있는 프로그램인지 확인해주시기 바랍니다. (어떤 어플리케이션에서만 종속적으로 사용되도록 설치된 프로그램을 이용하는 것이라면 문제를 발생시킬 수 있기 때문입니다.)
