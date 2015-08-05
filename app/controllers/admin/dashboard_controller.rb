class Admin::DashboardController < Admin::ApplicationController
  def past_day
    @user_count = User.past_day.count
    @micropost_count = Micropost.past_day.count
    @comment_count = Comment.past_day.count
    @like_count = Like.past_day.count
    render :show
  end

  def past_day_users_count
    data = {}
    6.downto 1 do |i|
      time = Time.now
      b_time = time - (4 * i).hours
      a_time = time - (4 * (i-1)).hours
      count = User.between_times(b_time, a_time).count
      data[a_time.strftime("%m-%d %H:%M")] = count
    end

    respond_to do |format|
      format.json { render json: data }
    end
  end

  def past_week
    @user_count = User.past_week.count
    @micropost_count = Micropost.past_week.count
    @comment_count = Comment.past_week.count
    @like_count = Like.past_week.count
    render :show
  end

  def past_week_users_count
    data = {}
    6.downto 0 do |i|
      date = Date.today - i
      count = User.by_day(date).count
      data[date] = count
    end

    respond_to do |format|
      format.json { render json: data }
    end
  end

  def past_month
    @user_count = User.past_month.count
    @micropost_count = Micropost.past_month.count
    @comment_count = Comment.past_month.count
    @like_count = Like.past_month.count
    render :show
  end

  def past_month_users_count
    data = {}
    3.downto 0 do |i|
      date = Date.today - i*7
      count = User.by_week(date).count
      data[date] = count
    end

    respond_to do |format|
      format.json { render json: data }
    end
  end

  def past_year
    @user_count = User.past_year.count
    @micropost_count = Micropost.past_year.count
    @comment_count = Comment.past_year.count
    @like_count = Like.past_year.count
    render :show
  end

  def past_year_users_count
    data = {}
    11.downto 0 do |i|
      date = Date.today - i.months
      count = User.by_month(date).count
      data[date.strftime("%Y-%m")] = count
    end

    respond_to do |format|
      format.json { render json: data }
    end
  end
end
