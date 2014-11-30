function setUserData( user ){
	if( user !== null ){
		d3.select("#userInfoArea").select("label")
			.text( user.name );
	}else{
		userData = {
			id: 1
		};
	}
}