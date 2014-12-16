class VotersController < ApplicationController
  before_action :set_voter, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @voters = Voter.all
    
    if session[:found_voter].is_a? Integer

      @cnp_voter = session[:found_voter]

    else
      @found_voter = nil

    end

    session[:new_vote_validation] = false

    respond_with(@voters)
  end

  def show
    respond_with(@voter)
  end

  def new
    @voter = Voter.new
    respond_with(@voter)
  end

  def edit
  end

  def create
    @voter = Voter.new(voter_params)
    @voter.save
    respond_with(@voter)
  end

  def update
    @voter.update(voter_params)
    respond_with(@voter)
  end

  def destroy
    @voter.destroy
    respond_with(@voter)
  end

  def voternotfound
    render voternotfound_path
  end

  def search_voter

    n = params[:cnp].to_i
    
    if Voter.all.where("cnp is ?", n).size != 0 then
      session[:found_voter] = Voter.find(params[:cnp]).cnp.to_i
      redirect_to voters_path
    else
      redirect_to voternotfound_path
    end    
  end

  def showvoters
    
    @cnp_id = params[:cnp].to_i


    puts @cnp_id

    @voter = Voter.find(@cnp_id)

    @alert = Alert.new
  

    render '/showvoters'
  end

  def votetime

    @voter = Voter.find(params[:cnp])
    @voter.update({:user_id => current_user.id})
    session[:new_vote_validation] = false
    
    redirect_to showvoters_path(:cnp => @voter.cnp)
  end


  def create_alert


    @alert = Alert.new
    @alert.description = params[:description]
    @alert.voter_cnp = params[:voter_cnp]
    @alert.current_user_id = params[:current_user_id]
    @alert.user_id = params[:user_id]
    @alert.time = params[:time]
    @alert.save

    @voter = Voter.find(@alert.voter_cnp)

    @voter.update({:user_id=>nil})


    redirect_to showvoters_path(:cnp => @alert.voter_cnp)
  end

  def double_voting
    session[:new_vote_validation] = true

    redirect_to showvoters_path(:cnp => params[:cnp])
  end

  def representatives
    @territory_users = User.all.where("field is ?", "Territory")
    render '/representatives'
  end

  def alertshall
    @all_alerts = Alert.all
    @all_voters = Voter.all
    @all_users = User.all.where("field is ?", "Territory")
    @alertscnp = Alert.all.group("voter_cnp")
    @alertsuser = Alert.all.group("user_id")
    
    render '/alertshall'
  end 

  def percentofall(x)
    (x.size * 100.0 / @allvoters.size).round(2)
  end

  def vpercentofall(x, y)
    if y.size != 0 then
      (x.size * 100.0 / y.size).round(2)
    else
      100.0
    end
  end

  def statistics
    @allvoters = Voter.all

    @listyoung = Array.new
    @listavg = Array.new
    @listold = Array.new

    @allvoters.each do |voter|
      l = voter.cnp.to_s[1..2].to_i
      if (l <= 96 && l >= 84) then
        @listyoung << voter
      elsif (l <= 83 && l >= 54) then
        @listavg << voter
      elsif (l < 53) then
        @listold << voter
      end
    end

    @percentlistyoung = percentofall(@listyoung)
    @percentlistavg = percentofall(@listavg)
    @percentlistold = percentofall(@listold)


    @listmen = Voter.all.where("cnp like ?", '1%')
    @percentlistmen = percentofall(@listmen)
    @listwomen = Voter.all.where("cnp like ?", '2%')
    @percentlistwomen = percentofall(@listwomen)

    @listrural = Voter.all.where("lower(zone) is ?", 'rural')
    @percentlistrural = percentofall(@listrural)
    @listurban = Voter.all.where("lower(zone) is ?", 'urban')
    @percentlisturban = percentofall(@listurban)

    @listbuc = Voter.all.where("lower(address) is ?", 'bucuresti')
    @percentlistbuc = percentofall(@listbuc)
    @listtim = Voter.all.where("lower(address) is ?", 'timisoara')
    @percentlisttim = percentofall(@listtim)
    @listbad = Voter.all.where("lower(address) is ?", 'badesti')
    @percentlistbad = percentofall(@listbad)
    @listros = Voter.all.where("lower(address) is ?", 'rosieni')
    @percentlistros = percentofall(@listros)

    @listvoters = Voter.all.where("user_id is not null")
    @percentlistvoters = percentofall(@listvoters)

    @vlistyoung = @listyoung.select{|voter| voter.user_id}
    @vlistavg = @listavg.select{|voter| voter.user_id}
    @vlistold = @listold.select{|voter| voter.user_id}

    @vpercentlistyoung = vpercentofall(@vlistyoung, @listyoung)
    @vpercentlistavg = vpercentofall(@vlistavg, @listavg)
    @vpercentlistold = vpercentofall(@vlistold, @listold)


    @vlistmen = @listmen.select{|voter| voter.user_id}
    @vpercentlistmen = vpercentofall(@vlistmen, @listmen)
    @vlistwomen = @listwomen.select{|voter| voter.user_id}
    @vpercentlistwomen = vpercentofall(@vlistwomen, @listwomen)

    @vlistrural = @listrural.select{|voter| voter.user_id}
    @vpercentlistrural = vpercentofall(@vlistrural, @listrural)
    @vlisturban = @listurban.select{|voter| voter.user_id}
    @vpercentlisturban = vpercentofall(@vlisturban, @listurban)

    @vlistbuc = @listbuc.select{|voter| voter.user_id}
    @vpercentlistbuc = vpercentofall(@vlistbuc, @listbuc)
    @vlisttim = @listtim.select{|voter| voter.user_id}
    @vpercentlisttim = vpercentofall(@vlisttim, @listtim)
    @vlistbad = @listbad.select{|voter| voter.user_id}
    @vpercentlistbad = vpercentofall(@vlistbad, @listbad)
    @vlistros = @listros.select{|voter| voter.user_id}
    @vpercentlistros = vpercentofall(@vlistros, @listros)

    render '/statistics'
  end

  private
    def set_voter
      @voter = Voter.find(params[:cnp])
    end

    def voter_params
      params.require(:voter).permit(:cnp, :last_name, :first_name, :address, :zone, :user_id)
    end

    def set_alert
      @alert = Alert.find(params[:id])
    end

    def alert_params
      params.require(:alert).permit(:description, :voter_cnp, :user_id, :current_user_id, :time)
    end

end
