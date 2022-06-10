class TestController < ApplicationController
    def index
        #data_redis = REDIS.HGET('FbmsG1weNNMmZeaVQo3Yg15g', '1') 
        #data_redis = REDIS.FLUSHALL()
        data_redis= REDIS.KEYS('*')
        render json: {data: data_redis}
    end
end
