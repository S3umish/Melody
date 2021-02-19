<p><%= form_tag(enrollment_path(@enrollment.id), method: :delete) do %></p>
      <%= submit_tag "Delete Lesson"%> 
    <% end %> 

    </p><%= form_tag(enrollment_path(@enrollment.id), method: :edit) do %></p>
      <%= submit_tag "Edit Lesson"%>
    <% end %>



    <%= link_to 'Edit Enrollment', edit_enrollment_path(@enrollment), class: "btn btn-warning text-white" %> 
    <%= link_to 'Delete Enrollment',enrollments_path(@enrollment), method: :delete, data: {confirm: 'Confirm'}, class: "btn btn-warning text-white" %> 
