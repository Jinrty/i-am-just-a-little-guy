using Godot;
using System;

public partial class MyMenuManager : Node
{
	private ConfirmationDialog _confirmationDialog;

	public override void _Ready()
	{
		// Reference your ConfirmationDialog node
		_confirmationDialog = GetNode<ConfirmationDialog>("ConfirmationDialog");

		// 1. Connect the 'Confirmed' signal (Triggers when OK is pressed)
		_confirmationDialog.Confirmed += OnConfirmed;

		// 2. Connect the cancel button's signal (Triggers when Cancel or 'X' is pressed)
        _confirmationDialog.GetCancelButton().Pressed += OnCanceled;
    }

    // Call this method whenever you need to display the pop-up
    public void TriggerDangerousAction()
    {
        // Center the dialog and display it to the player
        _confirmationDialog.PopupCentered();
    }

    private void OnConfirmed()
    {
        GD.Print("User clicked OK. Proceeding with the action!");
        // Insert your success logic here
    }

    private void OnCanceled()
    {
        GD.Print("User clicked Cancel or closed the window. Action aborted.");
        // Insert cleanup logic if needed
    }

    // Clean up event subscriptions when the node is destroyed
    protected override void Dispose(bool disposing)
    {
        if (disposing && _confirmationDialog != null)
        {
            _confirmationDialog.Confirmed -= OnConfirmed;
            _confirmationDialog.GetCancelButton().Pressed -= OnCanceled;
        }
        base.Dispose(disposing);
    }
}
