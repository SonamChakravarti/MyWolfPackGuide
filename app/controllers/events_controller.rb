class EventsController < ApplicationController

	@@event_id =0
	def self.event_id
		@@event_id		
	end


	def self.event_id=value
		@@event_id=value
	end


	def rsvp_events
		# display all the rsvp'd events for the logged in user
		
	end



	def rsvp_save
		event_title= params[:hid_etitle]
		cal_title= params[:hid_calName]
		eve_id=params[:hid_eid].strip
		cal_id=params[:hid_calendar_id]

		rsvp_new=Rsvp.new 
		rsvp_new.cal_id=cal_id # need to send calendar id from the calling page
		rsvp_new.event_id=eve_id
		rsvp_new.uid=session[:uid]	

		if rsvp_new.save!	
			flash[:notice]="Successfully RSVP's for the event!"
			redirect_to :controller=>'events',:action=>'event_detail', :etitle=>event_title,:calName => cal_title,:eid =>eve_id			
		else
			flash[:error]="Something went wrong with the request!"
			#render action: "event_detail"
			redirect_to events_detail_path
		end
	
	end

	def event_detail
			@event_title= params[:etitle]
			@cal_title= params[:calName]
			event_id=params[:eid]
			
			service=session[:service]		
			@cal = GCal4Ruby::Calendar.find(service,@cal_title, {})
			uid=session[:uid]
			@rsvp_button_flag=true

		if !event_id.nil?
			@@event_id=event_id.to_s
			# check if this user is rsvp'd for this event 
			event_rsvp_c1=Rsvp.find_by_uid_and_event_id(session[:uid].to_i,@@event_id)

			if !event_rsvp_c1.nil?
				@rsvp_button_flag=false;
			end		
			rsvpd_list=Rsvp.find_all_by_event_id(@@event_id)				
			# display the list of all the rsvp's people 
			# for each rsvp list item, using the uid find the username from users list			
			#@user_names = User.where()
			@user_names=[]
			@count=0
			if !rsvpd_list.nil?
				rsvpd_list.each do |rsvpd_user|					
					#@user_names[@count]=rsvpd_user.uid
					@user_names[@count]=User.find_by_id(rsvpd_user.uid)
						@count=@count+1					
				end
			end
		end			
			
	end

end
