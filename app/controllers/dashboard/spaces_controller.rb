class Dashboard::SpacesController < Dashboard::BaseController
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]
  before_action :only_space_owners!
  before_action :only_admins!, only: [:destroy]
  before_action :set_space, only: [:edit, :update, :publish, :destroy]

  def index
    if current_user.has_access_level?(:admin)
      @spaces = Space.order('created_at DESC').includes(:subscription, :user).page(params[:page])
    else
      @spaces = current_user.spaces.order('created_at DESC').includes(:subscription, :user).page(params[:page])
    end
  end

  def new
    redirect_to dashboard_plans_path if current_user.available_posts <= 0
    @space = Space.new(space_pictures: 3.times.map{ SpacePicture.new })
  end

  def create
    @space = current_user.spaces.build(space_params)
    if @space.save
      if current_user.available_posts > 0
        publish_form = Spaces::PublishForm.new(user: @space.owner, space: @space)
        if publish_form.valid? && publish_form.save!
          flash[:notice] = 'Space published'
          SpacesMailer.space_published(@space).deliver_later
          redirect_to dashboard_spaces_path
        else
          flash[:error] = publish_form.errors.full_messages.join('\n')
          redirect_to dashboard_spaces_path
        end
      else
        redirect_to dashboard_spaces_path, notice: 'Space has been created successfully'
      end

    else
      if @space.space_pictures.length < 3
        3.times{ @space.space_pictures.build }
      end
      render :new
    end
  end

  def edit
  end

  def update
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
    publish_form = Spaces::PublishForm.new(user: @space.owner, space: @space)
    if publish_form.valid? && publish_form.save!
      flash[:notice] = 'Space published'
      SpacesMailer.space_published(@space).deliver_later
      redirect_to dashboard_spaces_path
    else
      flash[:error] = publish_form.errors.full_messages.join('\n')
      redirect_to dashboard_spaces_path
    end
  end

  def destroy
    @space.destroy!
    flash[:notice] = 'Space permanently deleted'
    redirect_to dashboard_spaces_path
  end

  private

    def space_params
      params_list = [
        # Pricing
        :price_hourly, :price_daily, :price_buyout,
      ] + Space.amenities + [ :weekdays_availability_from, :weekdays_availability_to, :weekend_availability_from, :weekend_availability_to, :minimum_number_of_hours,
        # Days
        :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday,
        # Location
        :city_id, :address1, :address2, :zip_code,
        # General info
        :name, :classification, :phone_number, :capacity, :special_note, :description, :website,
        :document, :organization_description, category_ids: [],
        # Pictures
        space_pictures_attributes: [:temp_image_url, :temp_image_s3_key, :primary, :_destroy, :id]
      ]
      params.require(:space).permit(*params_list)
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(
        key: "tmp/space_pictures/user_#{current_user.id}-#{DateTime.now.iso8601}-#{SecureRandom.hex(4)}-${filename}",
        success_action_status: '201',
        acl: 'public-read'
      )
      puts @s3_direct_post.fields
    end

    def set_space
      if current_user.has_access_level?(:admin)
        @space = Space.find(params[:id])
      else
        @space = current_user.spaces.find(params[:id])
      end
    end
end


