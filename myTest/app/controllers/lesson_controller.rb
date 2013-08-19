class LessonController < ApplicationController
  before_filter :do_before, only: :step4

  def step1
    render text: "\"Hello, #{params[:name]}!!\" says #{params[:action]} in #{params[:controller]}"
  end

  def step2
    flash[:notice] = "You are being redirected to step3"
    redirect_to action: "step3"
    # redirect_to "/lesson/step3"
    # This also works, but the URL stays /step2
    #step3
  end

  def step3
    render text: flash[:notice]
    # render text: "This IS step3"
  end

  def step4
    render text: @message + "step4, coming up!"
  end

  def do_before
    @message = "doing before....\n"
  end

  def step5
    @price = (1000 * 1.05).floor
    @tag = "<strong>safe</strong>"
  end

  def step6
    @tag = "<script>alert(document.cookie)</script>"
    render "step5"
  end

  def step7
  end
end
