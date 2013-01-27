class ManController < ApplicationController
  def show
    @page_name = params[:id].gsub(/,/, '.')
    Open4::popen4("man -P cat #{@page_name}") {|p, i, o, e| @data = o.read.strip}
    @see_also = []
    @data.scan(/([a-z]*(\-.\s*)?[a-z\-\.]+)\(\d\)/m) do |m| 
      @see_also << m[0].tr("\n","").tr(' ','')
    end
    respond_to do |format|
      format.html
    end
  end
end

