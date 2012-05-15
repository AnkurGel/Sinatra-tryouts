%w(rubygems sinatra erb open-uri).each {|x| require x}
#very_ugly_and_basic file uploader crafted in sinatra - but worth for a minute code. 
before do
    @msg=nil
    @fileinfo=nil
end
get '/' do
    erb :index
end
post '/' do
    @fileinfo=params['file']
    unless @fileinfo.nil?
        File.open(params['file'][:filename],'w') do|f|
            f.write(params['file'][:tempfile].read)
        end
        @msg="File #{params['file'][:filename]} uploaded successfully!"
    end
    @url=params['urladd']
    unless @url.nil?
        File.open(File.basename(@url),'w:binary'){|x| x.write(open(@url, &:read))}
        @msg="File #{File.basename(@url)} successfully downloaded."
    end
    erb :index
end

__END__
@@index
<html>
<head>
</head>
<body>
<%=@msg unless @msg.nil?%>
<form method="POST" enctype="multipart/form-data">
<input type="file" name="file"><br/>
<input type="submit" value="Upload!">
</form>
<form method="POST">
<input type="text" name="urladd">
<input type="submit" value="Download!">
</form>
<%=@fileinfo unless @fileinfo.nil?%>
