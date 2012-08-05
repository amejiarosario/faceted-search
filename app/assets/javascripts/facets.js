$(function(){
	var url = /(.+)\?(.+)/.exec(document.URL)
	if(url){
		var base_url = url[1];
		var query_url = url[2].split("&");
		var non_token = ["sort", "direction"];

		for(f in query_url){
			filter = query_url[f];
			if(!(filter.indexOf('sort')>=0 || filter.indexOf('direction')>=0)){
				//$('.token-input-list').append(token_html(filter));	
				$('#facet-filters-tokens').append(token_html(filter));
			}
		}

		$('.token-input-delete-token-mac').on('click', function(){
			var parent = $(this).parent();
			$(parent).hide();
			var remove = $('.the_name', parent).html();
			var new_query = [];
			for(x in query_url){
				console.log("<<" +query_url[x]+" : "+remove);
				if(query_url[x].indexOf(remove) < 0){
					new_query.push(query_url[x]);					
				}
			}
			console.log(new_query);
			window.location = base_url + '?' + new_query.join("&");
		});
	}	
});

String.prototype.titleize = function() {
	var t = this.split(/[_\ ]/);
	var r = [];
	for( x in t){
		r.push(t[x].charAt(0).toUpperCase() + t[x].slice(1));
	}
	return r.join(" ");
}

function token_html(name){
	oname = name;
	name = unescape(name);
	name = name.split("=");
	name = name[0].titleize() + ": " + name[1].titleize();
	return '<li class="token-input-token-mac"><p>'+name+'</p><span class="the_name hidden">'+oname+'</span><span class="token-input-delete-token-mac">×</span></li>'
}