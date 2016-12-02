class Dashboard::SpacesController < Dashboard::BaseController
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]
  before_action :only_space_owners!

  def index
    @spaces = current_user.spaces.order('created_at DESC').page(params[:page])
  end

  def new
    @space = Space.new(space_pictures: 3.times.map{ SpacePicture.new })
  end

  def create
    @space = current_user.spaces.build(space_params)
    if @space.save
      redirect_to dashboard_spaces_path, notice: 'Space has been created successfully'
    else
      if @space.space_pictures.length < 3
        3.times{ @space.space_pictures.build }
      end
      render :new
    end
  end

  def edit
    @space = current_user.spaces.find(params[:id])
  end

  def update
    @space = current_user.spaces.find(params[:id])
    if @space.update(space_params)
      redirect_to dashboard_spaces_path, notice: 'Space has been updated successfully'
    else
      if @space.space_pictures.length < 3
        3.times{ @space.space_pictures.build }
      end
      render :edit
    end
  end

  def publish
    space = current_user.spaces.find(params[:id])
    publish_form = Spaces::PublishForm.new(user: current_user, space: space)
    if publish_form.save!
      flash[:notice] = 'Space published'
      redirect_to dashboard_spaces_path
    else
      flash[:error] = publish_form.errors.full_messages.join('\n')
      redirect_to dashboard_spaces_path
    end
  end

  private

    def space_params
      params.require(:space).permit(
        # Pricing
        :price_hourly, :price_daily, :price_buyout,
        # Amenities
        :wifi, :audio_visual, :projector, :white_board, :table_chair, :parking, :phone_number, :kitchen, :catering,
        # Availability
        :weekdays_availability_from, :weekdays_availability_to, :weekend_availability_from, :weekend_availability_to, :minimum_number_of_hours,
        # Days
        :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday,
        # Location
        :city_id, :address1, :address2, :zip_code,
        # General info
        :name, :classification, :phone_number, :capacity, :special_note, :description, :website, category_ids: [],
        # Pictures
        space_pictures_attributes: [:temp_image_url, :temp_image_s3_key, :_destroy, :id]
      )
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(
        key: "tmp/space_pictures/user_#{current_user.id}-#{DateTime.now.iso8601}-#{SecureRandom.hex(4)}-${filename}",
        success_action_status: '201',
        acl: 'public-read'
      )
      puts @s3_direct_post.fields
    end
end


