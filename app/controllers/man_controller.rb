class ManController < ApplicationController
  def show
    @man_type = params[:type]
    @page_name = params[:id].gsub(/,/, '.')
    @see_also = []
    @al = false

    Open4::popen4("man -P cat #{@man_type} #{@page_name}") {|p, i, o, e| @data = o.read.strip}

    if @data == "" && !@man_type.nil?
      @al = true
    elsif @data == ""
      @data = "Man Page not Found!"
    end
    
    @data.scan(/([a-z]*(\-.\s*)?[a-z\-\.]+)\((\d)\)/m) do |m| 
      @see_also << [m[0].tr("\n","").tr(' ',''),m[2]]
    end
    if not @al
      respond_to do |format|
        format.html
      end
    else
      redirect_to "/man/#{@page_name.tr('.',',')}", flash: { notice: "#{@page_name} not found in section #{@man_type}.  Defaulting to whatever it will show by default."}
    end
  end
end

