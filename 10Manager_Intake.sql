-- Insert intake
CREATE or alter PROCEDURE InsertIntake
    @ManagerID INT
AS
BEGIN
    DECLARE @Last_ID INT;
    SELECT @Last_ID = MAX(Intake_Id) FROM Manager.Intake;   

    -- Check if the Manager ID exists    
    IF NOT EXISTS (SELECT 1 FROM Manager.Manger WHERE Manger_ID = @ManagerID)
    BEGIN
        PRINT 'Error: Manager ID does not exist.';
        RETURN;
    END

    -- Insert new Intake record
    INSERT INTO Manager.Intake (Intake_Id, Manger_ID)
    VALUES (@Last_ID+1 ,@ManagerID);

    PRINT 'Intake inserted successfully.';
END;

EXEC InsertIntake @ManagerID = 8;

---------------------------------------------------------------

GO

-- Edit intake
CREATE OR ALTER PROCEDURE EditIntake
    @IntakeID INT,
    @NewManagerID INT     -- The manager who makes the update to this intake
AS
BEGIN
    -- Check if the Manager ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Manger WHERE Manger_ID = @NewManagerID)
    BEGIN
        PRINT 'Error: Manager ID does not exist.';
        RETURN;
    END

    -- Update Intake record
    UPDATE Manager.Intake
    SET Manger_ID = @NewManagerID
    WHERE Intake_Id = @IntakeID;

    PRINT 'Intake updated successfully.';
END;

exec EditIntake @IntakeID = 11 , @NewManagerID = 8;
