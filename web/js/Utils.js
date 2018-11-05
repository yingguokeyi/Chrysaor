

var Utils = {};
Utils.GetLength = function(str) {
    return str.replace(/[\u0391-\uFFE5]/g,"aa").length;  //先把中文替换成两个字节的英文，在计算长度
};

Utils.FormatDate = function(str) {
    if(str == ""){
        return ""
    }
    if(str == "0"){
        return "1970-01-01 08:00:00"
    }else{
        return "20"+str.substr(0,2)+"-"+str.substr(2,2)+"-"+str.substr(4,2)+" "+str.substr(6,2)+":"+str.substr(8,2)+":"+str.substr(10,2);
    }

}


Utils.FormatDateShort = function(str) {
    if(str == ""){
        return ""
    }
    if(str == "0"){
        return ""
    }else{
        return "20"+str.substr(0,2)+"-"+str.substr(2,2)+"-"+str.substr(4,2)+" "+str.substr(6,2)+":"+str.substr(8,2)+"";
    }

}

//金额分转元（保留两位小数）
Fen2Yuan = function( num ) {
    if ( typeof num !== "number" || isNaN( num ) ) return null;
    return ( num / 100 ).toFixed( 2 );
}
