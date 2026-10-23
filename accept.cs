using Godot;
using System;

public partial class accept : Node
{
	private ConfirmationDialog _confirmationDialog;

	public override void _Ready()
	{

		_confirmationDialog = GetNode<ConfirmationDialog>("ConfirmationDialog");

	
		_confirmationDialog.Confirmed += OnConfirmed;

		_confirmationDialog.GetCancelButton().Pressed += OnCanceled;
	}

	public void TriggerDangerousAction()
	{

		_confirmationDialog.PopupCentered();
	}

	private void OnConfirmed()
	{
		GD.Print("User clicked OK. Proceeding with the action!");

	}

	private void OnCanceled()
	{
		GD.Print("User clicked Cancel or closed the window. Action aborted.");
		// Insert cleanup logic if needed
	}


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
