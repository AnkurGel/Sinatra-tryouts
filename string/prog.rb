%w(sinatra rubygems erb).each{|x| require x}
disable :show_exceptions
before do
    @f=nil
end
get '/' do
    erb :index
end
post '/' do
    sentence=params[:sent]
    opt=params[:choice]
    if sentence==nil
        @f="ERROR! Write a sentence, you scumbag!" if sentence==nil
    else
        @f=case opt
           when "1" then reversesent(sentence)
           when "2" then reversewords(sentence)
           end
    end
    erb :index
end
def reversesent(sentence); sentence.chomp.reverse; end
def reversewords(sentence); sentence.chomp.split.map{|x| x.reverse}.join(' '); end

