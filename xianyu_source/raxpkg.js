service.register(options.serviceName,{create:function(id,env,config){return{RaxPkgService:function(weex){return{version:function(){return{v:'2.0.3',}}}}}},refresh:function(id,env,config){},destroy:function(id,env){}})