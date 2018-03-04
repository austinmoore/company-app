feature 'Employees' do
  scenario 'visit the empty index page' do
    company = FactoryBot.create(:company)
    visit company_employees_path(company)
    expect(page).to have_content 'Listing employees'
  end

  scenario 'visit the index page with employees' do
    company = FactoryBot.create(:company)
    e1 = FactoryBot.create(:employee, first_name: 'Bob', company: company)
    e2 = FactoryBot.create(:employee, first_name: 'Sally', company: company)
    other = FactoryBot.create(:employee, first_name: 'John')

    visit company_employees_path(company)

    expect(page).to have_content e1.first_name
    expect(page).to have_content e2.first_name
    expect(page).to_not have_content other.first_name
  end

  scenario 'create a new employee' do
    company = FactoryBot.create(:company)
    visit company_employees_path(company)

    click_link 'New Employee'
    expect(current_path).to eq(new_company_employee_path(company))
    first_name = 'John'
    fill_in('First name', with: first_name)
    last_name = 'Doe'
    fill_in('Last name', with: last_name)

    expect do
      click_button('Create Employee')
    end.to change(Employee, :count).from(0).to(1)

    expect(employee = Employee.first)
    expect(employee.first_name).to eq(first_name)
    expect(employee.last_name).to eq(last_name)
    expect(employee.company).to eq(company)
    expect(current_path).to eq(company_employee_path(company, employee))
    expect(page).to have_content first_name
    expect(page).to have_content last_name
    expect(page).to have_content 'Employee was successfully created.'
  end

  scenario 'show an existing employee' do
    employee = FactoryBot.create(:employee)
    visit company_employees_path(employee.company)

    click_link 'Show'
    expect(current_path).to eq(company_employee_path(employee.company, employee))
    expect(page).to have_content employee.first_name
    expect(page).to have_content employee.last_name

    click_link 'Back'
    expect(current_path).to eq(company_employees_path(employee.company))
  end

  scenario 'edit an existing employee' do
    employee = FactoryBot.create(:employee)
    visit company_employees_path(employee.company)
    click_link 'Edit'
    expect(current_path).to eq(edit_company_employee_path(employee.company,
                                                          employee))
    new_first_name = 'New First Name'
    fill_in('First name', with: new_first_name)
    new_last_name = 'New Last Name'
    fill_in('Last name', with: new_last_name)

    expect do
      click_button('Update Employee')
    end.to_not change(Employee, :count)

    employee.reload
    expect(employee.first_name).to eq(new_first_name)
    expect(employee.last_name).to eq(new_last_name)
    expect(current_path).to eq(company_employee_path(employee.company,
                                                     employee))
    expect(page).to have_content new_first_name
    expect(page).to have_content new_last_name
    expect(page).to have_content 'Employee was successfully updated.'
  end

  scenario 'delete an existing employee', js: true,
    skip: 'fails with WebDriverError on my machine. Wrote request spec instead' do
    employee = FactoryBot.create(:employee)
    visit company_employees_path(employee.company)

    expect do
      expect do
        accept_confirm do
          click_link 'Destroy'
        end
      end.to_not change(Company, :count)
    end.to change(Employee, :count).from(1).to(0)

    expect(current_path).to eq(company_employees_path(employee.company))
    expect(page).to have_content 'Employee was successfully destroyed.'
  end
end
