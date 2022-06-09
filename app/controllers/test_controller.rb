class TestController < ApplicationController
    def index
        #data_redis = REDIS.HGET('FbmsG1weNNMmZeaVQo3Yg15g', '1') 
        #data_redis = REDIS.FLUSHALL()
        #data_redis= REDIS.HVALS('99azt3ksCNPte1MppPhYH3qd')
        render json: {data: data_redis}
    end
end
