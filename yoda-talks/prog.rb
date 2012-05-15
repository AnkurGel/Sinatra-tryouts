%w(rubygems sinatra erb).each {|lib| require lib}
disable :show_exceptions
before do
    @f=nil
end
get '/' do
    erb :index
end

post '/' do
    sent=params[:sentence].chomp.upcase.gsub(/[^A-Z' ]/ ,'').split
    @f=revise_arr(sent).shuffle.join(' ')
    erb :index
end
def revise_arr(l)
   help_words=%w(are am is was were has have must shall could would should couldn't shouldn't musn't wouldn't may might may can can't will)
   help_words=help_words.join(' ').upcase.split; match_found=false
   help_words.each do |x|
      if l.include?(x)&&(l.index(x))!=0
         then
         i=l.index(x)-1
         l[i]+=" "+l[i+1];l.delete_at(i+1); match_found=true
      end
      break if match_found==true
   end
   help_words.each{|x| if (match_found==false)&&(l[0]==x) then l[0]+=" "+l[1]; l.delete_at(1); end}
   if l.include?('A') then i=l.index('A'); l[i]+=" "+l[i+1]; l.delete_at(i+1); end
   l
end
