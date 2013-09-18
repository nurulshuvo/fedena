

class SubjectsController < ApplicationController
  before_filter :login_required
  filter_access_to :all
  def index
    @batches = Batch.active
  end

  def new
    @subject = Subject.new
    @batch = Batch.find params[:id] if request.xhr? and params[:id]
    @elective_group = ElectiveGroup.find params[:id2] unless params[:id2].nil?
    respond_to do |format|
      format.js
    end
  end

  def create
    @subject = Subject.new(params[:subject])
    @batch = @subject.batch
    if @subject.save
      if params[:subject][:elective_group_id] == ""
        @subjects = @subject.batch.normal_batch_subject
        @normal_subjects = @subject
        @elective_groups = ElectiveGroup.find_all_by_batch_id(@batch.id)
        flash[:notice] = "Subject created successfully!"
      else
        @batch = @subject.batch
        @elective_groups = ElectiveGroup.find_all_by_batch_id(@batch.id, :conditions =>{:is_deleted=>false})
        @subjects = @subject.batch.normal_batch_subject
        flash[:notice] = "Elective subject created successfully!"
      end
    else
      @error = true
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @subject = Subject.find params[:id]
    @batch = @subject.batch
    @elective_group = ElectiveGroup.find params[:id2] unless params[:id2].nil?
    respond_to do |format|
      format.html { }
      format.js { render :action => 'edit' }
    end
  end

  def update
    @subject = Subject.find params[:id]
    @batch = @subject.batch
    if @subject.update_attributes(params[:subject])
      if params[:subject][:elective_group_id] == ""
        @subjects = @subject.batch.normal_batch_subject
        @normal_subjects = @subject
        @elective_groups = ElectiveGroup.find_all_by_batch_id(@batch.id)
        flash[:notice] = "Subject updated successfully!"
      else
        @batch = @subject.batch
        @elective_groups = ElectiveGroup.find_all_by_batch_id(@batch.id, :conditions =>{:is_deleted=>false})
        @subjects = @subject.batch.normal_batch_subject
        flash[:notice] = "Elective subject updated successfully!"
      end
    else
      @error = true
    end
  end

  def destroy
    @subject = Subject.find params[:id]
    @subject_exams= Exam.find_by_subject_id(@subject.id)
    if @subject_exams.nil?
      @subject.inactivate
    else
      @error_text = "#{t('cannot_delete_subjects')}"
    end
    flash[:notice] = "Subject Deleted successfully!"
  end

  def show
    if params[:batch_id] == ''
      @subjects = []
    else
      @batch = Batch.find params[:batch_id]
      @subjects = @batch.normal_batch_subject
      @elective_groups = ElectiveGroup.find_all_by_batch_id(params[:batch_id], :conditions =>{:is_deleted=>false})
    end
    respond_to do |format|
      format.js
    end
  end

end