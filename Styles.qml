import QtQuick 2.0

Item {
    property color mainBG: AppSettings.getVal("mainBG",-1) !== -1 ? AppSettings.getVal("mainBG") :"#242323"
    property color itemBG: AppSettings.getVal("itemBG",-1) !== -1 ? AppSettings.getVal("itemBG") :"#363535"
    property color mainFG: AppSettings.getVal("mainFG",-1) !== -1 ? AppSettings.getVal("mainFG") : "#855dd4"

    function setMainBG(value){
        mainBG = value;
        AppSettings.setVal("mainBG",value);
    }
    function setMainFG(value){
        mainFG = value;
        AppSettings.setVal("mainFG",value);
    }
    function setItemBG(value){
        itemBG = value;
        AppSettings.setVal("itemBG",value);
    }
}
